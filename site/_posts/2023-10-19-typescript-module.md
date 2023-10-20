---
layout: post
title:  "typescript: module"
---

<span class="hidden">Как настроить <strong>NPM-пакет</strong> на <strong>TypeScript</strong>, совместимый с <strong>React.js</strong>.</span>

## tl;dr

`package.json`:

```json
{
  "name": "my-package",
  "version": "0.1.0",
  "main": "lib/index.js",
  "types": "lib/index.d.ts",
  "devDependencies": {
    "typescript": "^5.2.2"
  }
}
```

`tsconfig.json`:

```json
{
  "compilerOptions": {
    "outDir": "lib",
    "declaration": true,
  },
  "include": [
    "src"
  ]
}
```

Это самые минимальные настройки, с только самыми нужными полями, чтобы всё заработало.

Объяснения, если он нужны — будут чуть ниже.

## Предыстория

У меня есть несколько сервисов, 4.5 из которых (да-да, именно столько) умеют разолвить **NPM**-пакеты.

- бэкенд (**Express.js**)
- фронтэнд (**React.js**)
- ещё один фронтэнд (**VS Code Extension**)
- тесты (**Mocha**)
- пакет под **Unity** — резолвится через UPM, тот самый 0.5 от **NPM**, т.к. это его урезанный форк

<img src="{{ site.baseurl }}/assets/images/three-dragons-npm-yarn-upm.jpg"
     height="360px"
     alt="Three dragon heads: NPM, YARN, UPM" />

Все, кроме последнего — написаны на **TypeScript**.

Между ними всеми, нужно было расшарить DTO, чтобы не гадать в каждый раз, что же я там между ними всеми передаю.

## Решения

### Protobuf

Казалось бы — самое очевидное решение, но оно мне не подошло ровно по той же причине, по которой и должно было подойти — **Unity**.

Казалось бы: ну опишу я DTO в `*.proto`-файлах, и можно радоваться: DTO скомпилируются и под **TypeScript**, и под **C#** — круто же?

Нет. Потому, что пакет под **Unity** подразумевается для подключения в крупные проекты, где уже может быть своя, конфликтующая версия `protoc`, а подталкивать зависимые проекты к рефакторингу зависимостей (а, конкретно — получению `protoc` строго через **UPM** — как-то не очень хочется: дорого, больно и, самое главное — никому не понятно, зачем).

### NPM

Ну тут всё понятно: распространяем зависимости для **JavaScript**/**TypeScript** нативным для них способом, и ничего (кроме TypeScript, ахаха) не компилируем.

Да, остаётся нерешённым вопрос про автоматическую генерацию **C#** кода с помощью изобретения велосипеда (всё, как мы любим) — но это, наверно, тема для отдельного поста.

## Так а в чём проблема-то?

Угадайте, кто в представленном стэке самый капризный?

- **Express.js**
- **React.js**
- **VS Code Extension**
- **Mocha**

Правильно! **React.js** исполнил виртуозную партию на моих и без того расстроенных нервах.

Если все остальные фреймворки — спокойно завелись с "дефолтной" (пара десятков минут гугления) конфигурацией пакета с дэтэохами, то реакт вдруг почему-то отказался видеть экспорт скомпилированного `enum` (хотя, всё-таки причина вряд ли именно в нём).

```log
Attempted import error: 'MyType' is not exported from 'my-package' (imported as 'MyType').
```

## Отладка

1. Добавляю во фронтэнд на **React.js** зависимость от пакета с DTO:

   ```diff
    "dependencies": {
      "react": "18.2.0",
      "react-clipboard.js": "2.0.16",
      "react-dom": "18.2.0",
      "react-router-dom": "6.15.0",
      "axios": "1.4.0",
   +  "my-package": "../my-package/my-package-0.1.0.tgz",
   },
   ```

   Да, у меня монорепа, и мне, пока что, лень пушить этот пакет в регистри, и тянуть его затем оттуда.
2. [Конфигурирую `my-package`](#tldr)
3. Добавляю скрипт в `my-package/package.json` для упаковки **TypeScript** кода в пакет `.tgz`:

   ```json
   "scripts": {
     "ts-pack": "npm install && npx tsc -b && npm pack"
   },
   ```

   Запуск `npx tsc -b`, здесь — обязательно нужен для того, чтобы **TypeScript** скомпилировался в **JavaScript**
4. Добавляю скрипт `build-my-package.sh`, который:
   - сбрасывает кэши `my-package`
   - компилирует `my-package`
   - перерезолвит зависимость от `my-package`

   ```bash
   #!/bin/bash

   set -e

   rm -rf my-package/lib

   rm -f my-package/tsconfig.tsbuildinfo
   (cd my-package && npm run ts-pack)

   rm -rf frontend/node_modules/my-package
   rm -f frontend/package-lock.json

   (cd frontend && npm install)
   (cd frontend && npm run build)
   ```

   Конечно, скрипт можно отрефакторить так, чтобы он умел резолвить все `*.tgz` зависимости для всех проектов в репозитории. Но это, опять же, наверно, тема для отдельного поста.

5. Запускаю `./build-my-package.sh` в каждый раз, когда меняю что-то в `my-package`

## Критично

- `"declaration": true` — генерирует на выходе также `*.d.ts`-файлы, для зависимых проектов на **TypeScript**
- `"types": "lib/index.d.ts"` — обязательно для импорта на **TypeScript**
- название папки с уже скомпилированными в **JavaScript** файлами (например, `lib`) должно совпадать, в следующих полях:
  - `"main": "lib/index.js"`
  - `"types": "lib/index.d.ts"`
  - `"outDir": "lib"`
- **не** использовать `"type": "module"`
- не забыть экспортнуть все типы из `src/index.ts` для того, чтобы они стали видимыми для импорта из `my-package`:

  ```typescript
  export { SomeCustomType } from './SomeCustomType'
  export { MyDTO } from './MyDTO'
  ```
