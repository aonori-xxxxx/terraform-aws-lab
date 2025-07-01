import json
import boto3


def lambda_handler(event, context):
    print(f"{json.dumps(event)}")
    try:
        body = json.loads(event.get("body", "{}"))
    except json.JSONDecodeError:
        return {
            "statusCode": 400,
            "body": json.dumps("リクエストボディがJSON形式ではないため、エラーを返します。"),
        }

    repo = body.get("content", {}).get("repository", {}).get("name", "unknown")

    # 処理対象のリポジトリ名を決める
    target_repo = "terraform-stg-osaka-ap-apply"

    # ステータス変更の情報を取り出す
    changes = body.get("content", {}).get("changes", [])
    if not changes:
        print("changesの中身が空なので処理をスキップします。")
        return {
            "statusCode": 200,
            "body": json.dumps("changesの中身が空なので処理をスキップします。"),
        }

    new_value = changes[0].get("new_value")
    if new_value != "3":
        print("プルリクエストが承認されていないため、CodeBuildの処理をスキップします。")
        return {
            "statusCode": 200,
            "body": json.dumps("プルリクエストが承認されていないため、CodeBuildの処理をスキップします。"),
        }

    # リポジトリ名が一致したら CodeBuild を実行
    if repo == target_repo:
        client = boto3.client("codebuild")
        response = client.start_build(
            projectName="stg-aws1-build-osaka-ap-apply",
            environmentVariablesOverride=[
                {"name": "REPO_NAME", "value": repo, "type": "PLAINTEXT"},
            ],
        )
        print(f"Started CodeBuild project: {response['build']['id']}")
        return {"statusCode": 200, "body": json.dumps("CodeBuildを正常に開始しました。")}
    else:
        print(f"{repo} からのイベントは対象外のためスキップします。")
        return {"statusCode": 200, "body": json.dumps("対象外のイベントのため処理をスキップしました。")}
