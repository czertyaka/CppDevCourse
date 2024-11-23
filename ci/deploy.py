import argparse
from pathlib import Path
import requests
import json


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-t",
        "--token",
        required=True,
        help="Yandex.Disk OAuth token",
        type=str,
    )
    parser.add_argument(
        "-d",
        "--directory",
        required=True,
        help="Directory with PDF files",
        type=Path,
    )
    args = parser.parse_args()
    return args.token, args.directory


def check_pdf_directory(directory):
    assert directory.is_dir()


def create_directory(api_url, token, path):
    print(f"Creating directory {path}...")
    headers = {"Accept": "application/json", "Authorization": f"OAuth {token}"}
    params = {"path": path}
    response = requests.put(api_url, headers=headers, params=params)
    status_code = response.status_code
    print(f"Status code {status_code}")
    assert status_code == 201 or status_code == 409


def publish_directory(api_url, token, path):
    print(f"Publishing {path}...")
    headers = {"Accept": "application/json", "Authorization": f"OAuth {token}"}
    params = {"path": path}
    data = {"public_settings": {"read_only": True}}
    data = json.dumps(data)
    response = requests.put(api_url, headers=headers, params=params, data=data)
    status_code = response.status_code
    print(f"Status code {status_code}")
    assert status_code == 200


def get_upload_url(api_url, token, path):
    print(f"Getting upload URL for {path}...")
    headers = {"Accept": "application/json", "Authorization": f"OAuth {token}"}
    params = {"path": path, "overwrite": "true"}
    response = requests.get(api_url, headers=headers, params=params)
    status_code = response.status_code
    print(f"Status code {status_code}")
    assert status_code == 200
    return response.json()["href"]


def upload_file(upload_url, path):
    print(f"Uploading file {path}...")
    data = open(path, "rb")
    response = requests.put(upload_url, data=data)
    status_code = response.status_code
    print(f"Status code {status_code}")
    assert status_code == 201


def main():
    api_url = "https://cloud-api.yandex.net/v1/disk/resources"
    token, directory = get_args()
    check_pdf_directory(directory)
    base_path = "ДПО Программирование современных логических устройств/2024"
    dirs = []
    files = []
    for path in Path(directory).rglob("*"):
        if path.is_dir():
            print(f"Collected directory: {path}")
            dirs.append(path)
        if path.is_file():
            print(f"Collected file: {path}")
            files.append(path)
    for subdirectory in dirs:
        relative_subdirectory = str(subdirectory.relative_to(directory))
        yandex_path = "/".join([base_path, relative_subdirectory])
        create_directory(api_url, token, yandex_path)
        publish_api_url = "/".join([api_url, "publish"])
        publish_directory(publish_api_url, token, yandex_path)
    for file in files:
        relative_file = str(file.relative_to(directory))
        yandex_path = "/".join([base_path, relative_file])
        upload_api_url = "/".join([api_url, "upload"])
        upload_url = get_upload_url(upload_api_url, token, yandex_path)
        upload_file(upload_url, file)


if __name__ == "__main__":
    main()
