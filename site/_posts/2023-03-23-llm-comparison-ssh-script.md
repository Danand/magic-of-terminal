---
layout: post
title:  "llm-comparison: ssh connection string script"
---

<span class="hidden">Сравнение gpt-4-turbo-preview и llama2 в написании простенького скрипта для коннкта по SSH.</span>

## Что тут

Просто попросим несколько разных языковых моделей написать простой скрипт, который предоставит возможность интерактивно выбирать SSH хост из файла `~/.ssh/config` (с помощью [**FZF**](https://github.com/junegunn/fzf)) для дальнейшего коннекта.

## Промпт

> Write Bash script which prepares terminal input of SSH connection string from `~/.ssh/config` entries using FZF.

### Фришные модели

Попробуем использовать [**Ollama**](https://ollama.com) – это модель и менеджер для запуска больших языковых моделей на локальной машине.

Работает так:

1. Устанавливаем (там всё однокнопочно).
2. Запускаем:

   ```bash
   ollama run llama2
   ```

3. Вводим промпт прямо в терминале.

## `llama2`

Это одноимённая (с самой запускалкой) модель, которая предлагается по умолчанию.

Скрипт из ответа – не работает. Делает что-то не то: запрашивает у меня ввести данные для коннекта вручную, и потом – зачем-то пытается внести их в конфиг (и то безуспешно).

```bash
#!/bin/bash

# Use FZF to search for matching SSH config entries
fzf_search="ssh-config --profile <profile> --hosts"

# Prompt user for input
echo -n "Enter the hostname or IP address of the server you want to connect to: "
read -r hosts

# Use FZF to find the matching SSH config entry
fzf_output=$(eval $fzf_search --profile $hosts)

# Extract the connection string from the output
connection_string=$(echo "$fzf_output" | grep -oE '^Host [a-zA-Z0-9.-]+$')

# Print the connection string
echo "Connection string: $connection_string"

# Add the selected server to the ~/.ssh/config file
echo "$hosts $connection_string" >> ~/.ssh/config
```

## `deepseek-coder:6.7b`

Это одна из моделей для **Ollama**, которая типа в топе для кодинга. Ну, проверим...

Скрипт из ответа – не работает. Падает на попытке сматчить невалидный `sed`-регекс. И, в конце, модель добавила ещё и галюны в виде какого-то левого **Python** кода с.. признанием в любви.

```bash
#!/bin/bash

# Function to read ssh config file and generate fzf menu
ssh_menu() {
    local cmd="cat ~/.ssh/config | sed -n '/^Host /{s/^Host //;p}'"
    eval $cmd | fzf --header "Select a host" --layout reverse --border --exit-0
}

# Get the selected ssh config entry and prepare it for use with ssh command
selected=$(ssh_menu)
if [ -n "$selected" ]; then
  read -p "Username (press enter for default): " username
  if [ -z "$username" ]; then
    # If no username was entered, we'll try to get it from the ssh config file.
    cmd="sed -n '/\[$selected\]/,/^\s*$/{/HostName/ {s/.*HostName //; p}}' ~/.ssh/config"
    host=$(eval $cmd)
  else
    read -p "Server IP (press enter for default): " server_ip
    if [ -n "$server_ip" ]; then
      ssh_command="ssh $username@$server_ip"
    else
      # If no server ip was entered, we'll try to get it from the ssh config file.
      cmd="sed -n '/\[$selected\]/,/^\s*$/{/HostName/ {s/.*HostName //; p}}' ~/.ssh/config"
      host=$(eval $cmd)
      ssh_command="ssh $username@$host"
   :from transformers import pipeline
nlp = pipeline('sentiment-analysis')
print(nlp("I love you"))
# [{'label': 'POSITIVE', 'score': 0.9836745262145996}]
```

### **ChatGPT**

В представлении не нуждается. Просто сравним вывод от двух актуальных моделей.

## `gpt-3.5-turbo`

Скрипт из ответа – не работает. Пытается исполнить сам конфиг целиком.

```bash
#!/bin/bash

# Get list of SSH hosts from ~/.ssh/config
ssh_hosts=$(awk '$1=="Host" {print $2}' ~/.ssh/config)

# Prompt user to select SSH host using fzf
selected_host=$(echo "$ssh_hosts" | fzf --prompt="Select SSH host: ")

# If user selects a host, construct the SSH connection string
if [[ -n "$selected_host" ]]; then
    ssh_config=$(awk -v host="$selected_host" '$1=="Host" && $2==host {flag=1} flag; /^$/{flag=0}' ~/.ssh/config)
    ssh_command="ssh $ssh_config"
    echo "Connecting to $selected_host..."
    echo "Executing: $ssh_command"
    # Execute the SSH command
    eval "$ssh_command"
else
    echo "No host selected. Exiting."
fi
```

## `gpt-4-turbo-preview`

Скрипт из ответа – _почти_ работает. Выводит нужную команду, но не даёт шанс исполнить её.

```bash
#!/bin/bash

# Script name: ssh-fzf.sh

# Read the Host names from the ssh config file
hosts=$(grep "^Host " ~/.ssh/config | awk '{print $2}')

# Check if hosts variable is empty
if [ -z "$hosts" ]; then
    echo "No hosts found in your SSH config."
    exit 1
fi

# Use fzf to select a host
selected_host=$(echo "$hosts" | fzf --height=40% --border)

# Check if a host was selected
if [ -n "$selected_host" ]; then
    # Output the SSH connection string
    echo "ssh $selected_host"
    # Alternatively, if you want to automatically connect, uncomment the following line:
    # ssh $selected_host
else
    echo "No host selected."
fi
```

### Моя реализация

Работает, но мне лень делать ещё и подстановку юзера из конфига (и так сойдёт – тем более, для моих нужд, там, реально, почти всегда будет `root`).

```bash
function ssh-fzf() {
  local host

  host="$( \
    cat ~/.ssh/config \
    | grep -o "^Host .*$" \
    | cut \
      -d " " \
      -f 2 \
    | fzf \
      --tac \
      --header="Pick SSH host:" \
      --layout="reverse" \
      --no-sort \
      --height="33%" \
  )"

  if [ -z "${host}" ]; then
    return 0
  fi

  read \
    -er \
    -i "ssh root@${host}" \
    -p "${PS1@P}" \
    input

  eval "${input}"
}
```
