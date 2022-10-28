# Rescue

소스코드의 작은 수정을 일으키는 언어의 정의와 해석기입니다.

## 작은 수정
작은 수정이란 "사소한 실수"로 인해 프로그램에 오류가 생긴 경우, 그 실수를 수정하는 것을 의미합니다.

## Rescue
Rescue는 작은 수정을 정의한 언어로 명령의 리스트로 이루어져 있습니다.
```
P = C*
C = ^ | v | < | >
  | backspace
  | insert(S)
S = UndefinedSemantics
  | ;
```
* `^`, `v`, `<`, `>`: 각각 커서를 상하좌우로 이동
* `backspace`: 커서 위치에서 한글자 지우기
* `insert(S)`: 커서 위치에서 `S` 삽입

Rescue 언어는 수정 대상의 맨 처음음 위치(가장 윗줄의 가장 처음 위치)에서 시작하여 동작합니다.

## 사용 방법
일관된 환경을 제공하기 위해 Docker를 이용합니다.
아래의 프로그램들을 설치합니다.
* Docker [[link]](https://docs.docker.com/desktop/)
* VSCode [[link]](https://code.visualstudio.com/download)
* remote container [[link]](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

프로그램을 빌드합니다.
```sh
$ opam install --yes core
$ dune install
```

프로그램을 수정합니다.
```sh
$ rescue -target <수정할 파일> <Rescue 프로그램>
```
* <수정할 파일>은 파일로 이용하거나, 직접 스트링을 넘겨도 됩니다.
* <Rescue 프로그램>은 파일로 이용하거나, 직접 스트링을 넘겨도 됩니다.
