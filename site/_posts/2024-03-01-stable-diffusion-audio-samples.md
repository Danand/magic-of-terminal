---
layout: post
title:  "stable diffusion: audio sample generator"
---

<span class="hidden">Генерируем one-shot аудио-сэмплы с помощью Stable Diffusion.</span>

## Идея

А что если генерировать звуки с помощью **Stable Diffusion**?

На выходе, получилось веб-приложение для генерации one-shot (т.е. коротких) аудио-сэмплов, которое работает так:

1. Загружаем в приложение существующие аудио-сэмплы.
2. Обучаем на них генеративную модель.
3. Генерируем новые сэмплы.
4. Слушаем; сохраняем результат, если понравился.

Зачем это нужно:

1. One-shot сэмплы – это самый элементарный материал для музыкального продакшена. Например, это может быть звук отдельного удара по барабану, щипок струны, нажатие клавиши синта и т.д. Но, обычно, это про ударные инструменты.
2. В музыкальном продакшене, многие битмейкеры стремятся к уникальности в звучании каждого сэмпла. Ну и, лично мне – нравятся всякие эксперименты, в т.ч. приводящие к откровенно какафоничному звучанию. Нейронка, как раз, должна справиться с такой задачей.

## Спектрограммы

Идея, сама по себе, не новая. Уже есть [**Riffusion**](https://www.riffusion.com) – это модель и экосистема для генерации коротких музыкальных фрагментов по заданному промпту.

Но, на самом деле, **Riffusion** всё так же генерирует картинки, но мы их слышим... как звуки. Что за магия такая? И зачем так сложно?

А всё потому, что **Stable Diffusion** заточен, в основном, под генерацию картинок. И для того, чтобы получить звук – нужно сначала получить картинку.

Картинка, в идеале, должна отражать отличия одного звука от другого, но, при этом, быть не слишком большой (не больше 768x768 или 1024x1024 пикселей).

<img src="{{ site.baseurl }}/assets/images/fig-snare-waveform.png"
     height="512px"
     alt="Snare drum waveform" />

Так выглядит самая простая визуализация звука. Но использовать её – очень неэффективно.

Дело в том, что она очень сжатая. Прям очень. Для того, чтобы закодировать звук какой-нибудь высокой ноты, нужно "отрисовать" тысячи колебаний, и уместить их в 512x512 пикселей (стандартное разрешение для **Stable Diffusion**, по состоянию на версию 1.5). Это нереально сделать без огромной потери качества.

Поэтому, для засовывания звука в **Stable Diffusion**, нужна другая визуализация.

Предыдущий пример это т.н. _time domain_ обработки сигнала. Т.е. запись каждого колебания на единицу времени. Человек может слышать около 22050 колебаний в секунду. Это слишком много для того, чтобы конвертировать звук в картинку.

Но есть ещё _frequency domain_: это когда обработка сигнала крутится вокруг одновременно звучащих "банков" частот, а не максимально возможного количества колебаний. Это тоже, по сути, сжатие. Но только более умное, с помощью умной математики.

Сжатие звука во _frequency domain_ делается с помощью [Быстрого Преобразования Фурье](https://en.wikipedia.org/wiki/Fast_Fourier_transform) – звучит страшно, но, например, с помощью этой же магии работают эквалайзеры (вроде бы). В общем, без какого-то там Фурье – нельзя бы было навалить басов. Как-то так.

**Так что за спектрограммы?**

Это, как раз-таки, сжатая, но достаточно читаемая для человеческого уха (после разжатия обратно), визуализация звука во _frequency domain_.

<img src="{{ site.baseurl }}/assets/images/kick-spectrogram.png"
     height="512px"
     alt="Kick drum spectrogram" />

## Зачем тут нужен велосипед

Существующая модель, **Riffusion** – не подходит для генерации one-shot сэмплов, т.к. она обучена генерировать музыкальные отрывки в 5 секунд, а нам нужны сэмплы покороче.

Да и инструментов для продвинутой работы с **Riffusion** не то, чтобы много: есть [`sd-webui-riffusion`](https://github.com/enlyth/sd-webui-riffusion), но в нём захардкожена длительность сэмпла и другие параметры спектрограммы.

Инструментов для подготовки данных к обучению – там тоже нет.

Да и обучение LoRA (маленькой модели) на базе [чекпоинта **Riffusion**](https://huggingface.co/riffusion/riffusion-model-v1) (большой модели), если честно – не дало удовлетворительных результатов. Базовая модель сильно _перевешивала_ LoRA: сгенерированные спектрограммы всё равно содержали скорее несколько ритмичных ударов, чем являлись бы ваншотами.

Следовательно, для задуманного проекта, можно вообще не пользоваться ни самим **Riffusion**, ни инструментами к нему.

## Зависимости

- [PyTorch](https://pytorch.org):
  - матеша
  - работа с аудио
  - работа с картинками
  - в целом, это непосредственно близко к нейронкам – не будет лишним поизучать
- [Pillow](https://pillow.readthedocs.io/en/stable):
  - некий стандартный формат для программирования над картинками
  - для него есть адаптеры и в **PyTorch**, и в **NumPy**
- [NumPy](https://numpy.org):
  - вообще, он обычно нужен для матеши (но ведь у нас уже есть **PyTorch**)
  - пригодится только для совместимости со **Streamlit**
- [Streamlit](https://streamlit.io):
  - фронтенд
  - да и бэкенд тоже – пофиг
  - очень удобен для визуализации всяких ML штук, по-быстрому – нам подходит

## Готовим сэмплы к конвертации

Для обучения генеративной модели, лучше использовать картинки одинакового размера. Следовательно, звуки, изначально – тоже должны быть одинаковой длительности (допустим, в 1 секунду). И, в целом, должны содержать одинаковый объём данных.

В итоге, для подготовки сэмплов, нужно:

1. Конвертировать все сэмплы в моно.
2. Конвертировать все сэмплы к единому sampling rate.
3. В начале сэмпла: отрезать тишину.
4. В конце сэмпла:
   - или добавить тишину (если сэмпл короче 1 секунды)
   - или отрезать после 1 секунды

Пишем вот такой код:

```python
import torch
from torchaudio.functional import resample

# Меняем sampling rate:
waveform_resampled = resample(
    waveform=waveform_orig,
    orig_freq=sample_rate,
    new_freq=resample_rate,
)

# Конвертируем в моно
# (да, звук в моно – это среднее значение
# между левым и правым каналом):
waveform_mono = torch.mean(
    input=waveform_resampled,
    dim=0, # Первое (с нуля) измерение матрицы – это 2 канала (если стерео).
    keepdim=True, # Не даём переворачивать измерения матрицы.
)

# Подрезаем в начале:
waveform_trimmed_silence = trim_silence(
    waveform=waveform_mono,
    threshold=silence_threshold,
)

# Подрезаем в конце:
waveform_trimmed_duration = trim_duration(
    waveform=waveform_trimmed_silence,
    duration=target_duration,
    sample_rate=resample_rate,
)

# Наращиваем в конце:
waveform_padded = pad_duration(
    waveform=waveform_trimmed_duration,
    duration=target_duration,
    sample_rate=resample_rate,
)
```

```python
# Используем матешу от PyTorch:
import torch

def trim_silence(
    waveform: torch.Tensor,
    threshold: float,
) -> torch.Tensor:
    # Звук в 1 секунду, с 1 каналом, с sampling rate 22050
    # – это матрица 1x22050

    # Вытаскиваем из матрицы обычный массив, размером в 22050:
    channel = waveform[0]

    first_index = 0

    for index, value in enumerate(channel):
        if value <= threshold:
            first_index = index
        else:
            break

    # Засовываем массив 22050 обратно в матрицу 1x22050:
    waveform_trimmed = torch.unsqueeze(channel[first_index:], 0)

    return waveform_trimmed

def trim_duration(
    waveform: torch.Tensor,
    duration: float,
    sample_rate: int,
) -> torch.Tensor:
    last_index = int(sample_rate * duration)

    # Здесь и далее,
    # `size()` возвращает размеры матрицы.
    # Звук в 1 секунду, с 1 каналом, с sampling rate 22050
    # – это матрица 1x22050, возвращается как массив [1, 22050]

    # Конкретно здесь, мы достаём размер второго (с нуля) измерения:
    sample_length = waveform.size(1)

    if sample_length <= last_index:
        return waveform

    channel = waveform[0]

    waveform_trimmed = torch.unsqueeze(channel[:last_index], 0)

    return waveform_trimmed

def pad_duration(
    waveform: torch.Tensor,
    duration: float,
    sample_rate: int,
) -> torch.Tensor:
    last_index = int(sample_rate * duration)

    sample_length = waveform.size(1)

    pad_size = last_index - sample_length

    if pad_size <= 0:
        return waveform

    # Наращивание матрицы:
    waveform_padded = torch.nn.functional.pad(
        input=waveform,
        pad=(0, pad_size), # Наращиваем матрицу вправо.
        value=0,
    )

    return waveform_padded
```

## Конвертируем звук в спектрограмму

```python
# Этот делегат можно переиспользовать в нескольких итерациях,
# если нужно конвертировать несколько звуков:
transform_mel_spectrogram = torchaudio.transforms.MelSpectrogram(
    sample_rate=resample_rate,
    n_fft=n_fft,
    win_length=win_length,
    hop_length=hop_length,
    f_min=f_min,
    f_max=f_max,
    pad=pad,
    n_mels=n_mels,
    window_fn=window_fn,
    power=power,
    normalized=normalized,
    norm=norm,
    mel_scale=mel_scale,
    center=center,
    pad_mode=pad_mode,
)

# Сам запуск конвертации:
mel_spectrogram: torch.Tensor = transform_mel_spectrogram(waveform_padded)
```

## Обучаем генеративную модель

Поскольку нам нужно обучить маленькую модель (LoRA) на основе большой модели **Stable Diffusion**, то нужно воспользоваться каким-нибудь готовым инструментом для обучения.

Обычно, для работы со **Stable Diffusion**, programmatically, используют [`diffusers`](https://huggingface.co/docs/diffusers/en/index) – это такая высокоуровневая обёртка от хаба, посвящённого diffusion нейронками и моделям, [**Hugging Face**](https://huggingface.co).

Но есть проблемка: [тренировка LoRA](https://huggingface.co/docs/diffusers/en/training/lora) там не прям хорошо задокументирована и, вообще – помечена как experimental. Страшно.

С другой стороны, есть другое, более надёжное решение, [kohya_ss/sd-scripts](https://github.com/kohya-ss/sd-scripts) – это ещё более высокоуровневая обёртка, которая получила развитие в форке с UI – [bmaltais/kohya_ss](https://github.com/bmaltais/kohya_ss), который, фактически, активно используется сообществом людей, которые генерируют картинки.

Подробнее, про обучение с `sd-scripts`, можно почитать у меня тут: [**Danand/stable-diffusion-scripts**](https://github.com/Danand/stable-diffusion-scripts?tab=readme-ov-file#lora-training)

Там же, можно почитать про подготовку картинок для обучения.

Обёртка с UI нам неинтересна, поэтому, можно сразу взять неповторимый оригинал.

Есть проблема: эти скрипты используют [`tqdm`](https://pypi.org/project/tqdm) для вывода прогрессбара через CLI, а нам нужно как-то пропихнуть отображение прогресса в **Streamlit**.<br />
Окей, делаем аккуратный форк, и делаем там абстракцию для инжекта любого отображения прогресса:

> [Add usage of abstract UI wrapper instead of `tqdm` at `train_network.py`](https://github.com/Danand/sd-scripts/commit/dcf2cd8e065f38f8336eeb670fe8ddb8da88fcfc)

Следующая проблема: зареференсить форк `sd-scripts` в нашем проекте. Мне лень делать из него полноценный питоновский пакет, поэтому – используем старые-_не_добрые сабмодули.

Добавляем сабмодуль с андерскорами вместо дефисов в названии (чтобы использовать в питоновских импортах):

```bash
git submodule add -- git@github.com:Danand/sd-scripts.git sd_scripts
```

Далее, при попытке запустить что-либо из сабмодуля – выскочит ошибки, т.к. сабмодуль использует внутри себя относительные пути в импортах, а для зависимого проекта, они уже не будут валидными.

Применяем грязный хак – добавляем, в самом начале зависимого скрипта, вот такой код:

```python
import sys

sys.path.append("sd_scripts")
```

Всё. Ошибки импортов ушли.

Делаем реализацию отображения прогресса:

> [Add bridge for injection of Streamlit progress into `sd-scripts`](https://github.com/Danand/audio-sample-generator/commit/72082faed9953b85c7e68ff15ffc0efa27379f31)

`sd-scripts` запускается через [`argparse`](https://docs.python.org/3/library/argparse.html), поэтому, нужен ещё один хак:

```python
from sd_scripts.train_network import setup_parser
from sd_scripts.library.train_util import read_config_from_file

from argparse import Namespace

# Создаёи имитацию передачи аргументов:
args_predefined = Namespace(
    pretrained_model_name_or_path=base_model,
    # Бла-бла-бла...
)

# Функция из `sd-scripts`, которая настраивает
# огромное дерево парсинга аргументов, в т.ч. для своих зависимостей:
parser = setup_parser()

# Есть возможность пропихнуть заготовленные аргументы, пользуемся:
args_parsed = parser.parse_args(namespace=args_predefined)

# Ещё какая-то обработка аргументов из `sd-scripts`:
args_enriched = read_config_from_file(args_parsed, parser)

# Не забываем про свою реализацию отображалки прогресса:
placeholder_progress = st.empty()
ui_wrapper_factory = UIWrapperFactoryStreamlit(placeholder_progress)

# Запускаем обучение:
trainer = NetworkTrainer()
trainer.train(args_enriched, ui_wrapper_factory)
```

В качестве базовой модели, берём [runwayml/stable-diffusion-v1-5](https://huggingface.co/runwayml/stable-diffusion-v1-5), потому что:

- она очень примитивная, и не перегружена лишними весами для генерации красивых картинок
- обучается быстрее SDXL
- не падает, при обучении, на моём компьютере (16GB RAM), в отличие от **SDXL** (более новой версии)

Кстати, вот ещё хак (для **MacOS**). Если обучение и/или генерация моделек падает по RAM, то можно попробовать запускать скрипты/приложухи с вот такой переменной среды:

```bash
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0
```

Теперь память будет пытаться аллоцироваться также из swap, но появится риск того, что крашнется ОС, и компьютер уйдёт в перезагрузку.

## Генерируем спектрограмму

А вот тут уже можно использовать [`diffusers`](https://huggingface.co/docs/diffusers/en/index), т.к. генерация там хорошо задокументирована, да и, как бы, там является основной целью (поэтому, с ней всё хорошо).

```python
pipeline = AutoPipelineForText2Image.from_pretrained(
    pretrained_model_or_path=base_model, # Тут `runwayml/stable-diffusion-v1-5`, но можно передать и путь к скачанной модели, из своей файловой системы.
    torch_dtype=torch.float32,
    safety_checker = None,
    requires_safety_checker = False,
).to(device_name)

# Берём возвращаемый тип пайплайна из документации,
# и кастим к нему, чтобы всё красиво подсвечивалось:
pipeline = cast(StableDiffusionPipeline, pipeline)

# Загружаем LoRA в пайплайн:
pipeline.load_lora_weights(
    pretrained_model_name_or_path_or_dict=lora_dir,
    weight_name=lora_name,
)

# Задаём вес LoRA:
pipeline.fuse_lora(
    lora_scale=lora_scale,
)

# Запускаем пайплайн генерации, и сразу кастим, для удобства:
output = cast(
    StableDiffusionPipelineOutput,
    pipeline(
        prompt=prompt,
        generator=generator,
        num_inference_steps=num_inference_steps,
        guidance_scale=guidance_scale,
        num_images_per_prompt=batch_size,
        callback=on_progress_steps,
        callback_steps=1,
    )
)
```

Сгенерированные картинки будут лежать в `output.images`, с типом `PIL.Image.Image`

## Конвертируем спектрограмму обратно в звук

Это самая магическая часть. Но не для программирования, а в том, что под ним скрыто – опять же, в математике. Не, ну прикиньте: какая-то непонятная картинка становится обратно звуком. Причём, почти таким же (ну ладно, на самом деле – чуть более мыльным).

Во всяких _научных_ либах уже есть готовые умные математические функции для этого.

### `librosa`

Функция из популярной либы для работы со звуком. Не используем её в задуманном приложении, но просто посмотрим, какой лаконичный тут интерфейс.

Пример использования [`librosa.feature.inverse.mel_to_audio`](https://librosa.org/doc/main/generated/librosa.feature.inverse.mel_to_audio.html):

```python
import numpy as np

import librosa
import soundfile

from PIL import Image

image = Image.open(fp=input_path).convert("F")
image_data = np.array(image)

audio_data = librosa.feature.inverse.mel_to_audio(
    image_data,
    sr=sample_rate,
    n_fft=n_fft,
    hop_length=hop_length,
)

soundfile.write(
    file=output_path,
    data=audio_data,
    samplerate=sample_rate,
    subtype="PCM_24",
)
```

Да, тут ещё несколько зависимостей нужно поставить (тех, что в импортах).

### `torchaudio`

Тут чуть сложнее.

Пример использования аж сразу двух функций:

- [`torchaudio.transforms.InverseMelScale`](https://pytorch.org/audio/stable/generated/torchaudio.transforms.InverseMelScale.html) – перегоняет мел-сектрограмму в обычную спектрограмму (на выходе – только математические данные, ещё не картинка)
- [`torchaudio.transforms.GriffinLim`](https://pytorch.org/audio/stable/generated/torchaudio.transforms.GriffinLim.html) – перегоняет обычную спектрограмму в данные картинки

```python
import torchvision
import torchaudio

from PIL import Image

import streamlit as st

# Допустим, тут сохранены настройки конвертации:
settings = get_spectrogram_to_audio_settings()

transform_inverse_mel_scale = torchaudio.transforms.InverseMelScale(
    n_stft=settings.n_fft // 2 + 1, # Какая-то магия.
    n_mels=settings.n_mels,
    sample_rate=settings.sample_rate,
    f_min=settings.f_min,
    f_max=settings.f_max,
    norm=settings.norm,
    mel_scale=settings.mel_scale,
    driver=settings.driver,
)

# Перегонялка картинки в PyTorch матрицу, т.к. дальше работаем с ней:
transform_image_tensor = torchvision.transforms.Compose([
    torchvision.transforms.ToTensor(),
    torchvision.transforms.Grayscale(),
])

transform_griffin_lim = torchaudio.transforms.GriffinLim(
    n_fft=settings.n_fft,
    n_iter=settings.n_iter,
    win_length=settings.win_length,
    hop_length=settings.hop_length,
    window_fn=settings.window_fn,
    power=settings.power,
    momentum=settings.momentum,
    length=settings.length,
    rand_init=settings.rand_init,
)

mel_spectrogram = transform_image_tensor(input_image).squeeze(0) * 255
lin_spectrogram = transform_inverse_mel_scale(mel_spectrogram)
waveform = transform_griffin_lim(lin_spectrogram)

st.audio( # Выводим аудио в веб-приложении Streamlit.
    data=waveform.numpy(), # Конвертируем `torch` матрицу в `numpy` матрицу, т.к. только её и понимает Streamlit.
    sample_rate=settings.sample_rate,
)
```

## Так, стоп: что за **мел**-спектрограмма?

Мелы – единица измерения высоты звука. Это ещё не ноты, но уже и не просто герцы. Это... _логарифмические герцы_, которые как бы адаптированы, в своём масштабе, к человеческому слуху.

Не знаю, насколько это правда: но это, будто бы, ещё и потому, что какая-то там штука, в ухе – закручена в логарифмическую завитушку.

По такой логике: чем выше звук, тем более он различим для человеческого уха. Следовательно, мел-спектрограмма будет более детальной для высоких частот (они будут выглядеть шире), и менее детальной – для низких. Мне показалось, что считается, что такая спектрограмма чем-то лучше и точнее, чем обычная. Ну ладно.

## Верстаем приложение на **Streamlit**

Да тут всё изи:

```python
import streamlit as st

title = "Some title"

st.set_page_config(
    page_title=title,
)

st.title(title)

if st.button("Do something"):
    st.text("Hello world")
```

Реактивно, примитивно, удобно.

Для всех доступных компонентов – есть понятная [документация](https://docs.streamlit.io/library/api-reference).

## Результат

Репозиторий:<br />
[**Danand/audio-sample-generator**](https://github.com/Danand/audio-sample-generator)

Видосик:

<video controls width="900" style="max-width: 100%;">
  <source src="{{ site.baseurl }}/assets/videos/audio-sample-generator.webm" type="video/webm">
  `recall-fzf` usage video was here.
</video>

Звук на входе:

<audio controls>
  <source src="{{ site.baseurl }}/assets/audio/808-kick-original.wav" type="audio/mpeg">
  Audio was here.
</audio>

Звук на выходе:

<audio controls>
  <source src="{{ site.baseurl }}/assets/audio/808-kick-generated.wav" type="audio/mpeg">
  Audio was here.
</audio>
