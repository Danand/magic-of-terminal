---
layout: post
title:  "bash-alias-sync: docker, fzf"
---

<span class="hidden">Немного элиасов для <b>Docker</b>.</span>

## Контекст

Это продолжение постов про [`bash-alias-sync`](https://danand.github.io/magic-of-terminal/posts/bash-allias-sync-touch-p).<br />
И, да: ниже представлены функции (`function`), а не буквально элиасы (`alias`), потому, что мне так удобнее:

1. Функции можно сделать видимыми в других функциях и скриптах.
2. Многострочные функции, в отличие от элиасов:
   - гораздо легче писать (с подсветкой)
   - не нужно эскейпить

## Prerequisites

Для того, чтобы представленные ниже функции работали, нужно чтобы были установлены кое-какие зависимости:

1. Сам [**Docker**](https://docs.docker.com/engine/install/) (ради чего всё это задумывалось):

   ```bash
   curl \
    -fsSL "https://get.docker.com" \
    -o "get-docker.sh" && \
   sudo sh "get-docker.sh"
   ```

2. [**Command-line Fuzzy Finder (_aka_ FZF)**](https://github.com/junegunn/fzf):

   ```bash
   sudo apt update && \
   sudo apt install -y fzf
   ```

## Как это работает

По большей части, делаем следующее:

1. Ищем образ/контейнер по какому-нибудь критерию.
2. Выводим список найденных вхождений на экран.
3. Ожидаем ввода (выбор строчки из таблицы, как раз, с помощью `fzf`).
4. Выполняем что-то с выбранным образом/контейнером.

## Функции

### Выбиралка ID контейнера (используется дальше)

```bash
function docker-container-fzf() {
  local container

  container="$( \
    docker ps "$@" \
    | tail -n +2 \
    | fzf \
    | cut \
      -d " " \
      -f 1 \
  )"

  echo "${container}"
}
```

### Смотрим логи

```bash
function docker-logs-fzf() {
  local container
  container="$(docker-container-fzf)"

  docker logs \
    --follow \
    --timestamps \
    --details
}
```

### Стопаем контейнер

```bash
function docker-stop-fzf() {
  local container
  container="$(docker-container-fzf)"

  docker stop "${container}"
}
```

### Убиваем контейнер (это как стопаем, но только делаем это _без уважения_)

```bash
function docker-kill-fконейтнерzf() {
  local container
  container="$(docker-container-fzf)"

  docker kill "${container}"
}
```

### Цепляемся к терминалу запущенного контейнера

```bash
function docker-exec-fzf() {
  local container
  container="$(docker-container-fzf)"

  docker exec -it "${container}" "$@"
}
```

Например, так:

```bash
docker-exec-fzf /bin/bash
```

### Рестартим контейнер (must-have)

```bash
function docker-restart-fzf() {
  local container
  container="$(docker-container-fzf -a)"

  docker restart "${container}"
}
```

### Удаляем стопнутый контейнер

```bash
function docker-rm-fzf() {
  local container
  container="$(docker-container-fzf -f "status=exited")"

  docker rm "${container}"
}
```

### Интерактивно удаляем образы

```bash
function __docker_list_ancestors() {
  local parent_row="$1"

  local parent_id
  parent_id="$(echo "${parent_row}" | cut -d " " -f 1)"

  docker ps -a -f "ancestor=${parent_id}"
}

export -f __docker_list_ancestors

function docker-rmi-fzf() {
  local image_ids

  image_ids="$( \
    docker image ls --format="{{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}" \
    | column -t \
    | fzf \
      --multi \
      --preview='__docker_list_ancestors {}' \
      --bind="ctrl-a:select-all" \
    | cut \
      -d " " \
      -f 1 \
  )"

  echo "${image_ids}" \
  | while read -r image_id; do
      if [ -n "${image_id}" ]; then
        docker rmi --force "${image_id}"
      fi
    done
}
```

<div style="max-width: 800px;">
  <video controls>
    <source src="{{ site.baseurl }}/assets/videos/docker-rmi-fzf.webm" type="video/webm">
    `docker-rmi-fzf` usage video was here.
  </video>
</div>

### На случай, когда мало места на диске

```bash
function docker-stop-all() {
  docker stop "$(docker ps -q)"
}

function docker-kill-all() {
  docker kill "$(docker ps -q)"
}

function docker-rm-all() {
  docker rm "$(docker ps -a -q)"
}

function docker-rmi-all() {
  docker rmi -f "$(docker images -aq)"
}

# Осторожно, удаляет ВООБЩЕ ВСЕ артефакты Docker:
function docker-prune() {
  yes | docker system prune -a --force
}
```
