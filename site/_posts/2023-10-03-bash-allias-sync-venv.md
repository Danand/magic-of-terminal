---
layout: post
title:  "bash-alias-sync: venv"
---

<span class="hidden">Немного элиасов для <b>Python</b>.</span>

## Контекст

Это продолжение постов про [`bash-alias-sync`](https://danand.github.io/magic-of-terminal/posts/bash-allias-sync-touch-p).<br />

## Мотивация

Если станет душно — [пролистывайте](#элиасы) чуть ниже.<br />
Есть, короче, такая штука для **Python**, как [virtual environment (_aka_ `venv`)](https://docs.python.org/3/library/venv.html).
Это инструмент для создания изолированного окружения для установки зависимостей.

Пример: допустим, я хочу поставить `numpy`, но не хочу, чтобы его новая вышедшая версия конфликтанула с какой-нибудь старой версией, которая уже была установлена глобально через `pip install numpy`. Поэтому, я делаю, вместо этого, так:

```bash
# Создаём venv:
python -m venv .venv

# Активируем `venv` — т.е. говорим текущей сессии терминала
# о том, что теперь все команды `python` и `pip`
# теперь должны выполняться в окружении внутри директории,
# в которой мы создали `venv`:
source .venv/bin/activate

# Устанавливаем `numpy` в `venv`"
pip install numpy
```

Удобно, супер-правильно, бест практисес, всё такое. Но многословно как-то.

## Элиасы

### Создаём `venv`

```bash
function venv-create() {
  python -m venv .venv
}
```

### Активируем `venv`

```bash
function venv-activate() {
  source .venv/bin/activate
}
```

### Деактивируем `venv`

Тут получилось даже многословнее, но зато мнемотичнее:

```bash
function venv-deactivate() {
  deactivate
}
```

### Удаляем/сбрасываем `venv`

```bash
function venv-reset() {
  rm -rf .venv
}
```

### "Восстанавливаем" зависимости (необязательно внутри `venv`)

Аналог `npm install` (**Node.js**) или `dotnet restore` (**.NET**):

```bash
function pip-restore() {
  pip install \
    --require-virtualenv \
    -r requirements.txt
}
```

### Удаляем установленные зависимости (необязательно внутри `venv`)

```bash
function pip-uninstall-all() {
  pip freeze \
  | xargs pip uninstall \
      --require-virtualenv \
      -y
}
```

## Почему `.venv` где-то с точкой, а где-то `venv` — без точки

* `venv` — это модуль для выполнения команды `python -m venv`
* `.venv` — это название подпапки, в которой будет развёрнуто виртуальное окружение

В UNIX-like (**MacOS**, **Linux**) системах, названия файлов, начинающиеся с точки — по умолчанию, считаются как бы _скрытыми_ (на самом деле, нифига они не скрытые — не прячьте там свои секретики, ахаха).
Так что, как раз, такая "скрытая" папка подходит для складывания туда всяких там установленных зависимостей и прочих файлов, на которые не очень удобно будет наткнуться при поиске по всей папке с проектом.

## Примечание

* `.venv/bin/activate` — это путь, специфичный для UNIX-like систем
* `.venv\Scripts\activate` — это путь для **Windows**
