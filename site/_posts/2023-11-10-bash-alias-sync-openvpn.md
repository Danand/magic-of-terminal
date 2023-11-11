---
layout: post
title:  "bash-alias-sync: openvpn"
---

<span class="hidden">Про элиасы для OpenVPN CLI.</span>

## Контекст

Это продолжение постов про [`bash-alias-sync`](https://danand.github.io/magic-of-terminal/posts/bash-allias-sync-touch-p).<br />
И, да: ниже представлены функции (`function`), а не буквально элиасы (`alias`), потому, что мне так удобнее:

1. Функции можно сделать видимыми в других функциях и скриптах.
2. Многострочные функции, в отличие от элиасов:
   - гораздо легче писать (с подсветкой)
   - не нужно эскейпить

## Мотивация

Если используем OpenVPN CLI, то "зачем это нужно" — понятно.

## Prerequisites

1. Регаемся тут: [ipinfo.io](https://ipinfo.io)
2. Сохраняем полученный там токен куда-нибудь в `~/.bashrc`

   ```bash
   export IPINFO_TOKEN="YOUR-TOKEN-HERE"
   ```

## Функции

### Фоновый коннект OpenVPN через дефолтный профиль

```bash
function openvpn-connect() {
  # Тут везде используем `sudo`,
  # т.к. процесс `openvpn` стартует на всю систему.

  # По-тихому гасим все процессы `openvpn`:
  sudo killall openvpn 2>/dev/null

  # Стартуем `openvpn` в фоне:
  # - `> /dev/null` — перенаправляет вывод вникуда
  # - `2>&1` — перенаправляет вывод ошибок в обычный вывод
  #   (а затем — вникуда, как задано тут же)
  # - `&` — делает запуск команды в фоне
  # - `nohup` — защищает фоновую команду от завершения
  #   после того, как будет завершена сессия
  #   из которой эта команда была запущена.
  sudo nohup openvpn "/etc/openvpn/client.conf" > /dev/null 2>&1 &

  # Спим 5 секунд, чтобы успеть подключиться,
  # перед тем, как проверить свой публичный IP:
  sleep 5

  echo "Connected"
  echo

  echo "Current IP info:"

  # Выводим свой публичный IP после подключения:
  curl "https://ipinfo.io/?token=${IPINFO_TOKEN}"
  echo
}
```

### Дисконнект подключения OpenVPN

```bash
function openvpn-disconnect() {
  sudo killall openvpn > /dev/null 2>&1

  sleep 5

  echo "Disconnected"
  echo

  echo "Current IP info:"

  curl "https://ipinfo.io/?token=${IPINFO_TOKEN}"
  echo
}
```

### Смена используемой конфигурации клиента OpenVPN

Работает только если все конфиги сохранены в `/etc/openvpn`, но это можно и переделать, по вкусу.

```bash
function openvpn-profile-fzf() {
  rm -f "/etc/openvpn/client.conf"

  find "/etc/openvpn" \
    -name "*.ovpn" \
    -or -name "*.conf" \
  | fzf \
  | cp "$(cat)" "/etc/openvpn/client.conf"
}
```
