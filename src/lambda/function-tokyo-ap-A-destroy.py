import json
import boto3


def lambda_handler(event, context):
    print(f"Received event: {json.dumps(event)}")
    try:        
        body = json.loads(event.get("body", "{}"))
    except json.JSONDecodeError:        
        return {"statusCode": 400, "body": json.dumps("Invalid JSON in body")}

    repo = body.get("content", {}).get("repository", {}).get("name", "unknown")

    # 処理対象のリポジトリ名を決める
    target_repo = "terraform-stg-tokyo-ap-A-destroy"

    # ステータス変更の情報を取り出す
    changes = body.get("content", {}).get("changes", [])
    if not changes:
        print("No changes found. Skipping.")
        return {"statusCode": 200, "body": json.dumps("No changes, build skipped.")}

    new_value = changes[0].get("new_value")
    if new_value != "3":
        print("プルリクエストは承認されなかったので、codebuild処理は飛ばします。")
        return {
            "statusCode": 200,
            "body": json.dumps("プルリクエストは承認されなかったので、codebuild処理は飛ばします。"),
        }

    # リポジトリ名が一致したら CodeBuild を実行
    if repo == target_repo:
        client = boto3.client("codebuild")
        response = client.start_build(
            projectName="stg-aws1-build-tokyo-ap-A-destroy",
            environmentVariablesOverride=[
                {"name": "REPO_NAME", "value": repo, "type": "PLAINTEXT"},
            ],
        )
        print(f"Started CodeBuild project: {response['build']['id']}")
        return {"statusCode": 200, "body": json.dumps("CodeBuild started successfully")}
    else:
        print(f"Event from {repo} ignored.")
        return {"statusCode": 200, "body": json.dumps("Event ignored")}
