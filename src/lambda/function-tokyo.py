import json
import boto3

def lambda_handler(event, context):
    print(f"Received event: {json.dumps(event)}")
    try:
        body = json.loads(event.get("body", "{}"))
    except json.JSONDecodeError:
        return {
            "statusCode": 400,
            "body": json.dumps(
                "リクエストボディがJSONではない。"
            ),
        }

    repo = body.get("content", {}).get("repository", {}).get("name", "unknown")

    repo_to_project = {
        "terraform-stg-tokyo-ap-A": "stg-aws1-build-tokyo-ap-A",
        "terraform-stg-tokyo-ap-B": "stg-aws1-build-tokyo-ap-B",
        "terraform-stg-common": "stg-aws1-build-common",
        "switchover": "stg-aws1-build-switchover",
    }

    changes = body.get("content", {}).get("changes", [])
    if not changes:
        print("changesの中身が空なので処理をスキップ。")
        return {
            "statusCode": 200,
            "body": json.dumps("changesの中身が空なので処理をスキップ。"),
        }

    new_value = changes[0].get("new_value")
    if new_value != "3":
        print("プルリクエストがマージ以外なので処理を中断。")
        return {
            "statusCode": 200,
            "body": json.dumps(
                "プルリクエストがマージ以外なので処理を中断。"
            ),
        }

    if repo in repo_to_project:
        project_name = repo_to_project[repo]
        client = boto3.client("codebuild")
        response = client.start_build(
            projectName=project_name,
        )
        print(f"Started CodeBuild project: {response['build']['id']}")
        return {
            "statusCode": 200,
            "body": json.dumps("CodeBuildを正常に開始しました。"),
        }
    else:
        print(f"{repo} からのイベントは対象外のためスキップします。")
        return {
            "statusCode": 200,
            "body": json.dumps("対象外のイベントのため処理をスキップしました。"),
        }
