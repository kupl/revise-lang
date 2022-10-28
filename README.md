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
S = raise UndefinedSemantics
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

저장소를 다운 받아 VSCode로 폴더를 엽니다.
```sh
$ git clone https://github.com/kupl/rescue-lang.git
$ code rescue-lang
```

VSCode의 명령창을 열어(Windows에서 `F1` 또는 `Ctrl + Shift + P`, Mac에서 `CMD + Shift + P`) `Reopen in Container`를 검색하여 선택합니다.

VSCode의 터미널을 열어(``Ctrl + ` ``) 프로그램을 빌드합니다.
```sh
$ opam install --yes core
$ dune install
```

Rescue 프로그램으로 소스코드를 수정합니다.
```sh
$ rescue [-verbose] [-inplace] -target <수정할 파일> <Rescue 프로그램>
```
* <수정할 파일>: 수정할 파일 또는 문자열
* <Rescue 프로그램>: Rescue 프로그램 파일 또는 문자열
* `-verbose`: 수정 과정 시각화
* `-inplace`: 수정 사항 반영
