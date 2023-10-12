---
layout: post
title:  "git: conflicts: statement body"
---

<span class="hidden">Почему однострочные ифы без фигурных скобок — это плохо.</span>

## Контекст

Довольно часто, я оставляю задолбавшие всех комментарии в мердж-реквестах. Больше половины этих комментов — suggestions на тему фигурных скобок в теле `if`:

```diff
-  if (true) std::cout << "Hello from my application!" << std::endl;
+  if (true) {
+    std::cout << "Hello from my application!" << std::endl;
+  }
```

## Зачем так душнить

Показываю, наглядно.

### Добавление нового кода

#### Если скобок не было

Допустим, у нас есть вот такой код, с `if` без кудрявых скобок:

```cpp
#include <iostream>

int main() {
  if (true) std::cout << "Hello from my application!" << std::endl;

  return 0;
}
```

Добавляем "фичу" в код, где изначально не было кудрявых скобок:

```diff
 #include <iostream>
 
 int main() {
-  if (true) std::cout << "Hello from my application!" << std::endl;
+  if (true) {
+    std::cout << "Hello from my application!" << std::endl;
+    std::cout << "Hello from feature A!" << std::endl;
+  }
 
   return 0;
 }

```

```bash
$ git diff --stat
 run.cpp | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
```

#### Если скобки уже были

А теперь, представим, что этот код изначально уже был с кудрявыми скобками:

```cpp
#include <iostream>

int main() {
  if (true) {
    std::cout << "Hello from my application!" << std::endl;
  }

  return 0;
}
```

Добавляем "фичу" в код с уже имеющимися кудрявыми скобками:

```diff int main() {
   if (true) {
     std::cout << "Hello from my application!" << std::endl;
+    std::cout << "Hello from feature A!" << std::endl;
   }
 
   return 0;
 }

```

```bash
$ git diff --stat
 run.cpp | 1 +
 1 file changed, 1 insertion(+)
```

#### Сравниваем количество изменений

**1** изменение (с фигурными скобками) против **5** изменений (без фигурных скобок)!

Больше изменений — больше конфликтов!

Мы же не хотим конфликтовать?
