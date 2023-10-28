---
layout: post
title:  "terminal-theme: halloween-2023"
---

<span class="hidden">"Небольшой рассказ про создание хеллоуинской темы для терминала".</span>

## Контекст

Давно хотелось создать собственную тему для терминала, но сделать это именно _по науке_.

Под "наукой" я здесь понимаю использование скиллов художника/дизайнера, которых у меня нет.

Но сделать-то хочется! И тут, как раз, появился повод: Хеллоуин. Это же точно то время, когда превращение чего-либо в тыкву — это норма.

## Делаем тему для терминала

### Теория

Правильнее, наверно, говорить "тема для эмулятора терминала".

Эмуляторами терминала являются, например:

- **Windows Terminal**
- **Gnome Terminal**
- **MinTTY**
- **Terminal** (**MacOS**)

Эмуляторы терминала, как правило, предоставляют возможность настроить 16 цветов + ещё парочку для фона, курсора и т.д.

Под "настроить", тут, подразумевается то, что каждый из этих 16 цветов можно заменить на любой другой цвет (не соответствующий даже его названию). Так, например, можно сделать всё полностью зелёным.

| Какая-то обычная тема | Полностью зелёная тема
| --- | --- |
| <img src="{{ site.baseurl }}/assets/images/terminal-theme-google-dark.png" /> | <img src="{{ site.baseurl }}/assets/images/terminal-theme-mono-green.png" /> |

### Так как делать-то

Честно — без понятия.

Всё, что я знаю про красивости относительно цветовой палитры: есть, короче, какой-то цветовой круг, и по нему можно смотреть то, какие цвета хорошо контрастируют и сочетаются между собой.

Так, стоп. Именно это же мне и нужно!

<video controls width="900" style="max-width: 100%;">
  <source src="{{ site.baseurl }}/assets/videos/color-wheel-adobe-compound.webm" type="video/webm">
  Adobe Color Wheel: Compound
</video>

Порядок действий такой:

1. Берём какую-нибудь существующую тему, приятную для субъективного восприятия.
2. Переносим цвета этой чьей-то готовой темы на цветовой круг.
3. Хватаемся за цвет терминала, который хотим сделать хеллоуинским.
4. Крутим цветовой круг.
5. Получаем новые цвета, для своей новой темы. Но с соблюдением "красивого" расстояния между цветами, как в теме, которая была взята за референс.

Но нет, это так не работает.<br />
Ну, либо у меня не получилось найти инструмент цветового круга, в котором можно было бы крутить именно кастомные цвета.

<video controls width="900" style="max-width: 100%;">
  <source src="{{ site.baseurl }}/assets/videos/color-wheel-adobe-custom.webm" type="video/webm">
  Adobe Color Wheel: Custom
</video>

А ведь это, опять-таки, повод что-нибудь запрограммировать... Например, крутящийся кастомный цветовой круг!

Изобретаю колесо, в прямом смысле.

### Как крутить

Теоретически, так:

1. Вычисляем разницу между цветами: от которого крутим, к которому крутим.
2. Добавляем эту разницу ко всем цветам "круга", и получаем новые, сдвинутые на нужное расстояние, цвета.

#### Color space: RGB

Привычные для всех hex-коды цветов — это RGB color space.

Покрутить RGB будет довольно затруднительно, т.к. RGB — это:

- красный (от 0.0 до 1.0)
- зелёный (от 0.0 до 1.0)
- синий (от 0.0 до 1.0)

И тут сразу непонятно:

- а что делать, если одна из компонент вылезет за 1.0?
  - клэмпить?
  - рипитить?
- не будет ли искажён финальный результат, в случае вылезания за граничные значения?

Как-то слишком много вопросов и, в целом, использование RGB color space выглядит как-то ненадёжно и неправильно.

#### Color space: HSL

Но ведь есть ещё HSL color space:

- оттенок (от 0° до 360° градусов)
- насыщенность (от 0.0 до 1.0)
- свет (от 0.0 до 1.0)

Тут упоминаются градусы! И, как раз, градусы используются для того, чтобы задать оттенок! Значит, этот color space идеально подходит для поворачивания цветового круга!

На самом деле, я знаю про всё это всего лишь из крутилок в любом графическом редакторе. Так, например, можно смоделировать нашу ситуацию в **Krita** (опенсорсный аналог **Adobe Photoshop**):

<video controls width="900" style="max-width: 100%;">
  <source src="{{ site.baseurl }}/assets/videos/hsl-krita.webm" type="video/webm">
  Krita: Edit HSL
</video>

Но мне лень подбирать нужный оттенок в каком-то там графическом редакторе. Тем более что, придётся крутить не только _hue_, но и _saturation_, и _lightness_.<br />
Хочу писать код, и неважно, что это займёт больше времени!

### Программируем поворачивающийся кастомный цветовой круг

Используем модуль [`colormath`](https://github.com/gtaylor/python-colormath) для **Python**, который, как раз, в т.ч. умеет делать конвертации между color spaces:

```python
from typing import List

from colormath.color_objects import ColorBase, HSLColor
from colormath.color_conversions import convert_color

from .colorwheel_utils import rotate_color

class Wheel:
    def __init__(self, colors: List[ColorBase]):
        self.colors = colors

    def rotate_from_to(self, color_from: ColorBase, color_to: ColorBase) -> List[ColorBase]:
        hsl_color_from: HSLColor = convert_color(color_from, HSLColor)
        hsl_color_to: HSLColor = convert_color(color_to, HSLColor)

        # Вычисляем разницу между цветом из темы-референса,
        # за который мы будем хвататься, вращая круг;
        # и цветом, до которого мы хотим вращать взятый цвет:

        diff_hue = hsl_color_to.hsl_h - hsl_color_from.hsl_h
        diff_saturation = hsl_color_to.hsl_s - hsl_color_from.hsl_s
        diff_lightness = hsl_color_to.hsl_l - hsl_color_from.hsl_l

        hsl_colors: List[HSLColor] = [convert_color(color, HSLColor) for color in self.colors]

        colors_rotated: List[ColorBase] = []

        for hsl_color in hsl_colors:
            # Вращаем:
            color_rotated = rotate_color(hsl_color, diff_hue, diff_saturation, diff_lightness)
            colors_rotated.append(color_rotated)

        return colors_rotated
```

Исходник `colorwheel_utils.py`:

```python
from colormath.color_objects import HSLColor

def normalize_saturation(saturation: float) -> float:
    if saturation == 1:
        return saturation
    else:
        return saturation % 1

def rotate_color(
        color: HSLColor,
        diff_hue: float,
        diff_saturation: float,
        diff_lightness: float,
    ) -> HSLColor:
    # `colormath` позволяет градус поворота больше 360° и меньше 0°
    # — так что, просто плюсуем разницу, и больше ничего не делаем:
    new_hue = color.hsl_h + diff_hue

    # А вот saturation должен быть от 0.0 до 1.0, рипитим:
    new_saturation = normalize_saturation(color.hsl_s + diff_saturation)

    # И lightness тоже должен быть от 0.0 до 1.0, клэмпим:
    new_lightness = max(0, min(1, color.hsl_l + diff_lightness))

    color_rotated = HSLColor(new_hue, new_saturation, new_lightness)

    return color_rotated
```

Теоретически, этого должно хватить. Но только тут ещё, как минимум, не хватает обёртки для работы с hex-кодами цветов.

Готовое решение генератора цветов терминала можно посмотреть в следующих репах:

- [https://github.com/Danand/colormath-colorwheel](https://github.com/Danand/colormath-colorwheel)
- [https://github.com/Danand/terminal-colors-generator](https://github.com/Danand/terminal-colors-generator)

### Ищем рефы

#### Реф темы, которую поворачиваем

Для создания собственной темы, нам понадобится следующий контент:

- тема-референс
- цвет, к которому мы повернём другой цвет темы-референса, вместо со всей темой-референс

Референс можно поискать на [windowsterminalthemes.dev](https://windowsterminalthemes.dev/) — это галерея тем для **Windows Terminal**.

Как только нам что-то понравилось — ищем [исходник темы в JSON](https://github.com/atomcorp/themes/blob/master/app/src/custom-colour-schemes.json).

Сохраняем JSON объект темы (на мой вкус — это **Monokai Pro**, жёлтенькая такая) в файл, например `theme-reference.json`:

```json
{
  "name": "Monokai Pro",
  "background": "#403e41",
  "black": "#403e41",
  "blue": "#fc9867",
  "brightBlack": "#727072",
  "brightBlue": "#fc9867",
  "brightCyan": "#78dce8",
  "brightGreen": "#a9dc76",
  "brightPurple": "#ab9df2",
  "brightRed": "#ff6188",
  "brightWhite": "#fcfcfa",
  "brightYellow": "#ffd866",
  "cursorColor": "#fcfcfa",
  "cyan": "#78dce8",
  "foreground": "#fcfcfa",
  "green": "#a9dc76",
  "purple": "#ab9df2",
  "red": "#ff6188",
  "selectionBackground": "#fcfcfa",
  "white": "#fcfcfa",
  "yellow": "#ffd866"
}
```

#### Реф цвета, к которому поворачиваем

Гуглим что-то вроде "bright pumpkin color", и сохраняем куда-нибудь hex-код.

### Пользуемся написанным кодом генератора цветов терминала

Пользуемся [обёрткой для поворачивания цветового круга](https://github.com/Danand/terminal-colors-generator):

1. Клонируем репу и ставим в ней зависимости:

   ```bash
   git clone git@github.com:Danand/terminal-colors-generator.git

   cd terminal-colors-generator

   python -m venv .venv
   source ./.venv/bin/activate
   pip install -r requirements.txt
   ```

2. Определяемся с цветами, от которого к которому поворачиваем, допустим:
   `#78dce8` — это `cyan` из **Monokai Pro**
   `#ea7600` — это яркий цвет тыквы, к которому мы повернём `cyan`

3. Запускаем саму утилиту:

   ```bash
   cat path-to/theme-reference.json | \
   python -m terminal_colors_generator \
     --color-from "#78dce8" \
     --color-to "#ea7600" \
     --export
   ```

4. Получаем что-то вроде этого:

   ```bash
   export TERMINAL_THEME_BLACK="#030603"
   export TERMINAL_THEME_RED="#538d97"
   export TERMINAL_THEME_GREEN="#bb0dcf"
   export TERMINAL_THEME_YELLOW="#5f559a"
   export TERMINAL_THEME_BLUE="#596994"
   export TERMINAL_THEME_MAGENTA="#8c9386"
   export TERMINAL_THEME_CYAN="#ea7600"
   export TERMINAL_THEME_WHITE="#b99ee2"
   export TERMINAL_THEME_BRIGHT_BLACK="#264633"
   export TERMINAL_THEME_BRIGHT_RED="#538d97"
   export TERMINAL_THEME_BRIGHT_GREEN="#bb0dcf"
   export TERMINAL_THEME_BRIGHT_YELLOW="#5f559a"
   export TERMINAL_THEME_BRIGHT_BLUE="#596994"
   export TERMINAL_THEME_BRIGHT_MAGENTA="#8c9386"
   export TERMINAL_THEME_BRIGHT_CYAN="#ea7600"
   export TERMINAL_THEME_BRIGHT_WHITE="#b99ee2"
   export TERMINAL_THEME_BACKGROUND="#030603"
   export TERMINAL_THEME_FOREGROUND="#b99ee2"
   export TERMINAL_THEME_CURSOR="#b99ee2"
   export TERMINAL_THEME_SELECTION_BACKGROUND="#b99ee2"
   ```

### Устанавливаем сгенерированную тему

Установка темы — тоже отдельная задача, которую нужно решать, т.к. установка темы под разные эмуляторы терминала — будет отличаться.

Например:

- для **Gnome Terminal** — это команды через CLI утилиту `dconf`
- для **Windows Terminal** — это добавление JSON объекта темы в файл `settings.json`

#### Установка на **Gnome Terminal**

Для установки тем на эмуляторы терминалов, популярных на UNIX-подобных системах (в т.ч. на **Gnome Terminal**), есть готовое решение — [**Gogh**](https://github.com/Gogh-Co/Gogh): это галерея + установщик тем.

Его я и использую (в качестве сабмодуля) в [своём установщике](https://github.com/Danand/terminal-themes) тем.

По сути, остаётся только [закинуть сгенерированную тему](https://github.com/Danand/terminal-themes/tree/main/themes) в мой установщик, и [прожать запуск скриптов](https://github.com/Danand/terminal-themes#installation) установки темы.

Сам **Gogh**, по умолчанию, умеет ставить только те темы, которые есть у него в галерее. Чтобы тема попала к нему в галерею, нужно закинуть её описание в YAML, и сделать Pull Request, после которого **GitHub Actions** workflow сам сгенерит скрипты-установщики и закоммитит их в репу.

Мне это не подходит: кому нафиг нужна моя безвкусная тема?

Поэтому, я пишу [скрипт](https://github.com/Danand/terminal-themes/blob/main/scripts/generate-themes.sh), который делает то же самое, что и [**GitHub Actions** workflow](https://github.com/Gogh-Co/Gogh/blob/master/.github/workflows/actions.yml), чтобы сгенерировать скрипты-установщики **Gogh** локально:

```bash
function generate_theme_gogh() {
  local theme_path="$1"

  local theme_name
  theme_name="$(get_theme_name "${theme_path}")"

  local theme_path_gogh="../submodules/gogh/themes/${theme_name}.yml"

  subst_template \
    "../templates/gogh.yml" \
    "${theme_path}" \
  > "${theme_path_gogh}"

  echo "Theme definition for Gogh generated at: ${theme_path_gogh}"

  pushd "../submodules/gogh" > /dev/null || return 2

  rm -rf ".venv"

  python3 -m "venv" ".venv"

  source "./.venv/bin/activate"

  pip3 install -r "requirements.txt"

  python3 "tools/generatJson.py"
  python3 "tools/generateJsonFiles.py"
  python3 "tools/generateShFiles.py"
  python3 "tools/updateThemes.py"

  deactivate

  echo "Done: theme artifacts for Gogh successfully generated"

  git status --short

  popd > /dev/null || return 2
}
```

#### Установка на **Windows Terminal**

Тут всё проще: нужно только перегнать тему из своего формата в JSON, понятный `settings.json`, в котором хранятся настройки (в т.ч. и темы) **Windows Terminal**:

```bash
source "../themes/${theme_installer_filename}.sh"
envsubst < "../templates/windows-terminal.json"
```

Ничего из этого уже не нужно писать, просто запускаем скрипты [по инструкции](https://github.com/Danand/terminal-themes#installation).

## Known issues

На самом деле, всё изложенное выже (касательно поворота цветового круга) — неправильно. Прям вообще.

Страшная правда, которую знает любой художник, в том, что _цвета не равны_ между собой, когда мы сравниваем контрастность двух разных цветов относительно другого цвета (например, фона терминала).

Поэтому, простой поворот оттенка с сохранением прежней читабельности — невозможен. Нужна какая-то коррекция.

### Delta E

Есть такая формула, [**Delta E**](https://en.wikipedia.org/wiki/Color_difference#CIELAB_%CE%94E*) (от нем. "Empfindung" — _восприятие_), по которой считаетается контрастность одного цвета относительно другого.

В `colormath` даже есть готовая функция для вычисления контрастности с использованием этой формулы:

```python
def calc_delta_e(color_left: LabColor, color_right: LabColor) -> float:
    color_left_vector = _get_lab_color1_vector(color_left)
    color_right_matrix = _get_lab_color2_matrix(color_right)

    delta_e = delta_e_cie2000(color_left_vector, color_right_matrix, 1, 1, 1)[0]

    return delta_e.item()
```

Казалось бы, раз уже есть готовая функция — можно взять и использовать.

Но нет. Функция `delta_e_cie2000` возвращает `float` значение, которое может подходить нескольким цветам, абсолютно не похожим друг на друга. И таким образом, при брутфорсе цветов с нужным **Delta E**, тёмная тема может стать светлой. Корректировать что-то ещё с учётом таких оказий — лично мне, что-то совсем лень.

И, да: ещё, наверно, брутфорсить цвет по значению контрастности — наверно, это как-то неправильно:

```python
def find_color_nearest_by_delta_e(color: LabColor, delta_e: float) -> sRGBColor:
    colors_to_delta_e_diff: List[Tuple[float, LabColor]] = []

    for color_lab_l in range(0, 10001):
        color_other = LabColor(color_lab_l / 100.0, color.lab_a, color.lab_b)
        delta_e_other = calc_delta_e(color, color_other)

        delta_e_diff = abs(delta_e_other - delta_e)

        colors_to_delta_e_diff.append((delta_e_diff, color_other))

    color_to_delta_e_diff_min = min(colors_to_delta_e_diff, key=lambda color_to_delta_e_diff: color_to_delta_e_diff[0])

    nearest_color_rgb: sRGBColor = convert_color(color_to_delta_e_diff_min[1], sRGBColor)

    return nearest_color_rgb
```

Скорее всего, нужно решать уравнение по вот этой формуле, но у меня на это не хватает серого вещества, к сожалению:

<img src="{{ site.baseurl }}/assets/images/formula-cie00.png"
     width="900px"
     alt="Formula: CIEDE2000" />

Выглядит жутко, пострашнее любого костюма на Хеллоуин!

## Итоги

Сделать хеллоуинскую тему _по науке_ — **не** получилось.

Зато получилось столкнуться с самым страшным монстром — собственной тупостью.

Ну да ладно: **и так сойдёт**!

<img src="{{ site.baseurl }}/assets/images/terminal-theme-halloween-2023-0.png"
     width="900px"
     alt="Terminal theme: Halloween 2023" />

<img src="{{ site.baseurl }}/assets/images/terminal-theme-halloween-2023-1.png"
     width="900px"
     alt="Terminal theme: Halloween 2023" />

<img src="{{ site.baseurl }}/assets/images/terminal-theme-halloween-2023-2.png"
     width="900px"
     alt="Terminal theme: Halloween 2023" />

<img src="{{ site.baseurl }}/assets/images/terminal-theme-halloween-2023-3.png"
     width="900px"
     alt="Terminal theme: Halloween 2023" />

<img src="{{ site.baseurl }}/assets/images/terminal-theme-halloween-2023-4.png"
     width="900px"
     alt="Terminal theme: Halloween 2023" />

<img src="{{ site.baseurl }}/assets/images/terminal-theme-halloween-2023-5.png"
     width="900px"
     alt="Terminal theme: Halloween 2023" />

Кстати, фиолетовый цвет ведьминской шляпы — это совпадение.<br />
Так что, точно: никакой науки тут нет, только магия.
