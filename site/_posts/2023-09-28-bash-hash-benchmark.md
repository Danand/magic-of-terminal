---
layout: post
title:  "bash-hash-benchmark"
---

<span class="hidden">Про замеры хэш-алгоритмов, доступных в <strong>Bash</strong>.</span>

## Мотивация

Никакой мотивации, ахааха.

За последующими сниппетами, кажется, нет никакого опыта практического применения, лично у меня.<br />
А, может быть, и есть.

Вроде бы, была какая-то ситуация, когда нужно было посчитать хэши для огромного количества файлов, и как-то сам собой возник (и также исчез) вопрос о том, _"а как же это сделать быстрее?"_.

Чисто интуитивно, кажется, что будто бы самый быстрый алгоритм хэширования, из популярных — это **MD5**. Ну, типа потому, что:

* его текстовое представление выглядит коротко и простенько 🤡
* в названии мало страшных шипящих букв 🤡
* в названии всего одна цифра 🤡

Собственно, этим мои знания могли бы и ограничиться, но любопытство-то — не знает границ. Тем более, что сделать замеры оказалось достаточно просто.

## Замеры

1. Методом непродолжительного гугления, можно найти список алгоритмов хэширования, встроенных в почти любой популярный **Linux** дистрибутив.
2. Закидываем их в список:

   ```bash
   algos=( \
     "md5sum" \
     "sha1sum" \
     "sha224sum" \
     "sha256sum" \
     "sha384sum" \
     "sha512sum" \
     "b2sum" \
     "openssl dgst -md5" \
     "openssl dgst -sha1" \
     "openssl dgst -sha256" \
     "openssl dgst -sha512" \
   )
   ```

3. Пишем примитивный запуск чего-то вроде бенчмарка:<br />[`hash-benchmark.sh`](https://github.com/Danand/bash-hash-benchmark/blob/main/hash-benchmark.sh)
4. Нагло пользуясь тем, что у них у всех одинаковая сигнатура, запускаем прогон для каждого, по очереди:

   ```bash
   for algo in "${algos[@]}"; do
     ./hash-benchmark.sh \
       "${algo}" \
       10 \
       104857600
   done \
   | sort -t $'\t' -k 2 -n \
   | column -s $'\t' -t
   ```

## Итоги

К моему удивлению, победителем оказался **SHA-1**, но именно в реализации [**OpenSSL**](https://www.openssl.org/).

### 100 MB file, 1 iteration

| Function | Time elapsed (ms.) |
|:--------|--------:|
| `openssl dgst -sha1` | 406 |
| `b2sum` | 427 |
| `md5sum`| 573 |
| `openssl dgst -md5` | 583 |
| `openssl dgst -sha512` | 529 |
| `sha1sum` | 678 |
| `openssl dgst -sha256` | 733 |
| `sha384sum` | 872 |
| `sha512sum` | 872 |
| `sha224sum` | 1354 |
| `sha256sum` | 1362 |

### 100 MB file, 10 iterations

| Function | Time elapsed (ms.) |
|:--------|--------:|
| `openssl dgst -sha1` | 4006 |
| `b2sum` | 4277 |
| `openssl dgst -md5` | 5086 |
| `openssl dgst -sha512` | 5170 |
| `md5sum` | 5249 |
| `sha1sum` | 5882 |
| `openssl dgst -sha256` | 7278 |
| `sha512sum` | 8452 |
| `sha384sum` | 8521 |
| `sha256sum` | 13423 |
| `sha224sum` | 13446 |

### 100 MB file, 100 iterations

| Function | Time elapsed (ms.) |
|:--------|--------:|
| `openssl dgst -sha1` | 38553 |
| `b2sum` | 42591 |
| `openssl dgst -md5` | 49940 |
| `md5sum` | 50033 |
| `openssl dgst -sha512` | 51910 |
| `sha1sum` | 57393 |
| `openssl dgst -sha256` | 71788 |
| `sha512sum` | 84725 |
| `sha384sum` | 84855 |
| `sha256sum` | 134613 |
| `sha224sum` | 132943 |

## Бонус

В интернетах ходят легенды об ещё более быстром алгоритме (чем все вышеперечисленные) — [**xxHash**](https://github.com/Cyan4973/xxHash).

Его можно поставить отдельно; например, через **APT**:

```bash
sudo apt update && \
sudo apt install -y xxhash
```

### 100 MB file, 10 iterations (**xxHash**)

| Function | Time elapsed (ms.) |
|:--------|--------:|
| `xxh128sum` | 236 |
| `xxhsum` | 307 |
| `xxh64sum` | 310 |
| `xxh32sum` | 430 |
| `openssl dgst -sha1` | 1429 |
