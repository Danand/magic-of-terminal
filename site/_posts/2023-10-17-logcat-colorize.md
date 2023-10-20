---
layout: post
title:  "logcat: colorize"
---

<span class="hidden">Про раскраску <code>logcat</code></span>

## Контекст

Как-то раз, насмотревшись на вывод `logcat` в **Android Studio** (он там цветной, более-менее), мне захотелось раскрашивать его прямо в терминале.

## Решения

### Решение: самописная раскраска

Прямо так сразу, ничего особо лучше этого — не получилось.

#### Реализация: самописная раскраска

```bash
#!/bin/bash

COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_RED="\033[0;31m"
COLOR_DIM="\033[2m"
COLOR_CLEAR="\033[0m"

while read -r line; do
  if echo "${line}" | grep -q " I Unity"; then
    echo -e "${COLOR_GREEN}${line}${COLOR_CLEAR}"
  elif echo "${line}" | grep -q " W Unity"; then
    echo -e "${COLOR_YELLOW}${line}${COLOR_CLEAR}"
  elif echo "${line}" | grep -q " E Unity"; then
    echo -e "${COLOR_RED}${line}${COLOR_CLEAR}"
  else
    echo -e "${COLOR_DIM}${line}${COLOR_CLEAR}"
  fi
done
```

#### Использование: самописная раскраска

```bash
logcat -s Unity | ./my-shitty-logcat-colorizer.sh
```

#### Вывод: самописная раскраска

<details>
  <summary>Output of my shitty colorizer</summary>

  <div class="container-log-fit">
    --------- beginning of main
    <br />
    <span class="terminal-green">10-18 00:46:36.633 23548 23614 I Unity : [2023-10-18
      05:46:36.627] UnityInitApplication
    </span>
    <br />
    <span class="terminal-green">10-18 00:46:36.633 23548 23614 I Unity :
      [2023-10-18 05:46:36.633] ApplicationModeVR
    </span>
    <br />
    <span class="terminal-green">10-18 00:46:36.635 23548 23614 I
      Unity : [2023-10-18 05:46:36.635] SetCurrentThreadAffinity
    </span>
    <br />
    <span class="terminal-green">10-18 00:46:36.640
      23548 23614 I Unity : [2023-10-18 05:46:36.640] RuntimeInitialize
    </span>
    <br />
    <span class="terminal-green">10-18
      00:46:36.689 23548 23614 I Unity : [2023-10-18 05:46:36.689] MountApk
    </span>
    <br />
    <span class="terminal-green">10-18
      00:46:36.721 23548 23614 I Unity : [2023-10-18 05:46:36.721] MountObbs
    </span>
    <br />
    <span class="terminal-green">10-18
      00:46:36.723 23548 23614 I Unity : [2023-10-18 05:46:36.723] MultiThreadStackTrace_Init
    </span>
    <br />
    <span
      class="terminal-green">10-18 00:46:36.723 23548 23614 I Unity : [2023-10-18 05:46:36.723] Signal handler for capture
      multi-threads stack register success!
    </span>
    <br />
    <span class="terminal-green">10-18 00:46:36.724 23548 23614 I Unity :
      [2023-10-18 05:46:36.724] MultiThreadStackTrace init success!
    </span>
    <br />
    <span class="terminal-green">10-18 00:46:36.724
      23548 23614 I Unity : [2023-10-18 05:46:36.724] securitylib_Init
    </span>
    <br />
    <span class="terminal-green">10-18
      00:46:36.731 23548 23614 I Unity : [2023-10-18 05:46:36.731] DeviceName 
    </span>
    <br />
    <span
      class="terminal-green">10-18 00:46:36.735 23548 23614 I Unity : [2023-10-18 05:46:36.735] SystemInfo CPU = ARM64 FP ASIMD
      AES, Cores = 8, Memory = 5593mb
    </span>
    <br />
    <span class="terminal-green">10-18 00:46:36.735 23548 23614 I Unity :
      [2023-10-18 05:46:36.735] SystemInfo ARM big.LITTLE configuration: 0 big (mask: 0), 8 little (mask:
      255)
    </span>
    <br />
    <span class="terminal-green">10-18 00:46:36.735 23548 23614 I Unity : [2023-10-18 05:46:36.735]
      ApplicationInfo com.miHoYo.GenshinImpact version 4.1.0_18054760_18121248 build
      6cd0a56d-433b-4312-b029-a27e8549f616
    </span>
    <br />
    <span class="terminal-green">10-18 00:46:36.735 23548 23614 I Unity :
      [2023-10-18 05:46:36.735] Built from '' branch, Version '2017.4.30f1 (0)', Build type 'Release', Scripting Backend
      'il2cpp'
    </span>
    <br />
    <span class="terminal-green">10-18 00:46:37.055 23548 23614 I Unity : [2023-10-18 05:46:37.055] Read
      and enabled 0 persistent code switches
    </span>
    <br />10-18 00:46:39.070 23548 23614 D Unity : GL_OES_EGL_image
    GL_OES_EGL_image_external GL_OES_EGL_sync GL_OES_vertex_half_float GL_OES_framebuffer_object GL_OES_rgb8_rgba8
    GL_OES_compressed_ETC1_RGB8_texture GL_AMD_compressed_ATC_texture GL_KHR_texture_compression_astc_ldr
    GL_KHR_texture_compression_astc_hdr GL_OES_texture_compression_astc GL_OES_texture_npot
    GL_EXT_texture_filter_anisotropic GL_EXT_texture_format_BGRA8888 GL_EXT_read_format_bgra GL_OES_texture_3D
    GL_EXT_color_buffer_float GL_EXT_color_buffer_half_float GL_QCOM_alpha_test GL_OES_depth24 GL_OES_packed_depth_stencil
    GL_OES_depth_texture GL_OES_depth_texture_cube_map GL_EXT_sRGB GL_OES_texture_float GL_OES_texture_float_linear
    GL_OES_texture_half_float GL_OES_texture_half_float_linear GL_EXT_texture_type_2_10_10_10_REV GL_EXT_texture_sRGB_decode
    GL_EXT_texture_format_sRGB_override GL_OES_element_index_uint GL_EXT_copy_image GL_EXT_geometry_shader
    GL_EXT_tessellation_shader GL_OES_texture_stencil8 GL_EXT_shader_io_blocks GL_OES_shader_image_atomic
    GL_OES_sample_variables GL_EXT_texture_b
    <br />10-18 00:46:39.070 23548 23614 D Unity : order_clamp
    GL_EXT_EGL_image_external_wrap_modes GL_EXT_multisampled_render_to_texture GL_EXT_multisampled_render_to_texture2
    GL_OES_shader_multisample_interpolation GL_EXT_texture_cube_map_array GL_EXT_draw_buffers_indexed GL_EXT_gpu_shader5
    GL_EXT_robustness GL_EXT_texture_buffer GL_EXT_shader_framebuffer_fetch GL_ARM_shader_framebuffer_fetch_depth_stencil
    GL_OES_texture_storage_multisample_2d_array GL_OES_sample_shading GL_OES_get_program_binary GL_EXT_debug_label
    GL_KHR_blend_equation_advanced GL_KHR_blend_equation_advanced_coherent GL_QCOM_tiled_rendering
    GL_ANDROID_extension_pack_es31a GL_EXT_primitive_bounding_box GL_OES_standard_derivatives GL_OES_vertex_array_object
    GL_EXT_disjoint_timer_query GL_KHR_debug GL_EXT_YUV_target GL_EXT_sRGB_write_control GL_EXT_texture_norm16
    GL_EXT_discard_framebuffer GL_OES_surfaceless_context GL_OVR_multiview GL_OVR_multiview2 GL_EXT_texture_sRGB_R8
    GL_KHR_no_error GL_EXT_debug_marker GL_OES_EGL_image_external_essl3 GL_OVR_multiview_multisampled_render_to_texture
    GL_E
    <br />10-18 00:46:39.070 23548 23614 D Unity : XT_buffer_storage GL_EXT_external_buffer
    GL_EXT_blit_framebuffer_params GL_EXT_clip_cull_distance GL_EXT_protected_textures
    GL_EXT_shader_non_constant_global_initializers GL_QCOM_texture_foveated GL_QCOM_texture_foveated_subsampled_layout
    GL_QCOM_shader_framebuffer_fetch_noncoherent GL_QCOM_shader_framebuffer_fetch_rate GL_EXT_memory_object
    GL_EXT_memory_object_fd GL_EXT_EGL_image_array GL_NV_shader_noperspective_interpolation
    GL_KHR_robust_buffer_access_behavior GL_EXT_EGL_image_storage GL_EXT_blend_func_extended GL_EXT_clip_control
    GL_OES_texture_view GL_EXT_fragment_invocation_density GL_QCOM_validate_shader_binary
    GL_QCOM_YUV_texture_gather
    <br />
    <br />
    <span class="terminal-red">10-18 00:46:39.074 23548 23614 E Unity : [2023-10-18
      05:46:39.074] HK4EUpload:Try to delete file
      /storage/emulated/0/Android/data/com.miHoYo.GenshinImpact/c124dfe0bc1c644acac37929fc0d8957_tmp
    </span>
    <br />
    <br />
    <span
      class="terminal-red">10-18 00:46:39.074 23548 23614 E Unity :
    </span>
    <br />
    <br />
    <span class="terminal-red">10-18
      00:46:39.074 23548 23614 E Unity : (Filename: Line: 2233)
    </span>
    <br />
    <br />
    <span class="terminal-red">10-18
      00:46:39.074 23548 23614 E Unity :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.304 23548 23614 W Unity :
      [2023-10-18 05:46:40.304] Begin Compile ComputeShader:BuildHIZ.HZBBuildCS
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:40.304 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:40.304 23548 23614 W Unity : (Filename: Line: 468)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.304
      23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.315 23548 23614 W Unity : [2023-10-18
      05:46:40.315] End Compile ComputeShader:BuildHIZ.HZBBuildCS
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:40.315 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.315 23548 23614 W Unity :
      (Filename: Line: 500)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.315 23548 23614 W Unity
      :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.316 23548 23614 W Unity : [2023-10-18 05:46:40.316] Begin
      Compile ComputeShader:BuildHIZ.HZBBuildCS
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.316 23548 23614 W
      Unity :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.316 23548 23614 W Unity : (Filename: Line:
      468)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.316 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:40.317 23548 23614 W Unity : [2023-10-18 05:46:40.317] End Compile
      ComputeShader:BuildHIZ.HZBBuildCS
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.317 23548 23614 W Unity
      :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.317 23548 23614 W Unity : (Filename: Line:
      500)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.317 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:40.317 23548 23614 W Unity : [2023-10-18 05:46:40.317] Begin Compile
      ComputeShader:BuildHIZ.HZBBuildCS
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.317 23548 23614 W Unity
      :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.317 23548 23614 W Unity : (Filename: Line:
      468)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.317 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:40.319 23548 23614 W Unity : [2023-10-18 05:46:40.319] End Compile
      ComputeShader:BuildHIZ.HZBBuildCS
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.319 23548 23614 W Unity
      :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.319 23548 23614 W Unity : (Filename: Line:
      500)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.319 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:40.320 23548 23614 W Unity : [2023-10-18 05:46:40.320] Begin Compile
      ComputeShader:BuildHIZ.HZBBuildCS
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.320 23548 23614 W Unity
      :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.320 23548 23614 W Unity : (Filename: Line:
      468)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.320 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:40.321 23548 23614 W Unity : [2023-10-18 05:46:40.321] End Compile
      ComputeShader:BuildHIZ.HZBBuildCS
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.321 23548 23614 W Unity
      :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.321 23548 23614 W Unity : (Filename: Line:
      500)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:40.321 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:43.508 23548 23614 I Unity : [2023-10-18 05:46:43.508] Genshin Start Log: GameManager
      Awake - NowTimeStamp:1697579203
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:43.550 23548 23614 I Unity :
      [2023-10-18 05:46:43.549] Genshin Start Log: GameManager Start - NowTimeStamp:1697579203
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:43.550 23548 23614 I Unity : [2023-10-18 05:46:43.550] Genshin Start Log: GameManager
      InitGame - NowTimeStamp:1697579203
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:43.565 23548 23614 I Unity :
      [2023-10-18 05:46:43.565] Load DownloadPref:
      {"resStatus":[0,0],"redownloadUselessAudio":false,"redownloadUselessVideo":false}
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:43.565 23548 23614 I Unity : DJMNDPNJCKD:OMMJEAGFEBP()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:43.565 23548 23614 I Unity : MoleMole.GameManager:HOOLDBCLMMF()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:43.565 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:43.565 23548 23614 I Unity : (Filename:
      E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:43.565 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:43.578 23548 23614 I Unity : [2023-10-18 05:46:43.578] IsBaseResVersionHashChanged=> baseResVersionHashInPersist
      = b8ad419157e6112db0fc9fb117ef4a9f, md5 in streamingResVersion =
      b8ad419157e6112db0fc9fb117ef4a9f
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:43.578 23548 23614 I Unity :
      MoleMole.GameManager:HOOLDBCLMMF()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:43.578 23548 23614 I Unity
      :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:43.578 23548 23614 I Unity : (Filename:
      E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:43.578 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:44.791 23548 23614 I Unity : [2023-10-18 05:46:44.791] [MTRManager]client create sucess!
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:44.791 23548 23614 I Unity : MoleMole.GameManager:AEHPIEMNCIN()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:44.791 23548 23614 I Unity : MoleMole.GameManager:HOOLDBCLMMF()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:44.791 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:44.791 23548 23614 I Unity : (Filename:
      E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:44.791 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:44.826 23548 23614 I Unity : [2023-10-18 05:46:44.826] Genshin Start Log: GameManager ShowLogo -
      NowTimeStamp:1697579204
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:44.888 23548 23614 I Unity :
      [2023-10-18 05:46:44.888] Genshin Start Log: LogoPageContext SetupView -
      NowTimeStamp:1697579204
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.884 23548 23614 I Unity :
      [2023-10-18 05:46:47.884] Genshin Start Log: LogoPageContext ClosePage -
      NowTimeStamp:1697579207
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.884 23548 23614 I Unity :
      [2023-10-18 05:46:47.884] Genshin Start Log: GameManager StartHome - NowTimeStamp:1697579207
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.916 23548 23614 I Unity : [2023-10-18 05:46:47.916] Genshin Start Log: GameManager
      ChangeGameWorld Home - NowTimeStamp:1697579207
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.924 23548
      23614 I Unity : [2023-10-18 05:46:47.924] Genshin Start Log: GameManager CreateNewGameWorld Home -
      NowTimeStamp:1697579207
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.939 23548 23614 I Unity :
      [2023-10-18 05:46:47.939] Genshin Start Log: Home LoadScene - NowTimeStamp:1697579207
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.961 23548 23614 I Unity : [2023-10-18 05:46:47.961] Texture streaming preload
      close!
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.961 23548 23614 I Unity :
      OLHIFOGGMIM:MoveNext()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.961 23548 23614 I Unity :
      UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:47.961 23548 23614 I Unity : UnityEngine.MonoBehaviour:StartCoroutine(IEnumerator)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.961 23548 23614 I Unity : JBLGLCLGBKE:CIIBFDCPMNB(IEnumerator,
      Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.961 23548 23614 I Unity :
      AEJMFLHFEPL:ILMJEICJEOM()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.961 23548 23614 I Unity :
      MoleMole.GameManager:KPHEGEBOONL(WorldType, UInt32, String, String)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:47.961 23548 23614 I Unity : MoleMole.EEGFAFEFKOC:LLDKNDHIIIH()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:47.961 23548 23614 I Unity : JFONKPLEEGN:Invoke()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.961
      23548 23614 I Unity : HKELOMNMLFL:Tick()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.961 23548 23614 I
      Unity : MoleMole.GameManager:ONCKPFPBFNI()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.961 23548 23614 I
      Unity : MoleMole.GameManager:Update()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.961 23548 23614 I
      Unity :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.961 23548 23614 I Unity : [ line
      273]
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.961 23548 23614 I Unity : (Filename: Line:
      273)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.961 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.961 23548 23614 I Unity : [2023-10-18 05:46:47.961] Genshin Start Log: GameManager
      FirstChangeToHomeCallback - NowTimeStamp:1697579207
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.966
      23548 23614 I Unity : [2023-10-18 05:46:47.966] Texture streaming preload close!
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.966 23548 23614 I Unity : KAEEPNKKCDK:JKANBEOJLHH()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.966 23548 23614 I Unity : MoleMole.GameManager:ABJOLHANEPM()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.966 23548 23614 I Unity : System.Action:Invoke()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.966 23548 23614 I Unity : MoleMole.EEGFAFEFKOC:LLDKNDHIIIH()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.966 23548 23614 I Unity : JFONKPLEEGN:Invoke()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.966 23548 23614 I Unity : HKELOMNMLFL:Tick()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.966 23548 23614 I Unity : MoleMole.GameManager:ONCKPFPBFNI()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.966 23548 23614 I Unity : MoleMole.GameManager:Update()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:47.966 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:47.966 23548 23614 I Unity : [ line 273]
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.966 23548
      23614 I Unity : (Filename: Line: 273)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:47.966 23548 23614 I
      Unity :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:48.393 23548 23614 I Unity : [2023-10-18 05:46:48.393]
      Genshin Start Log: LoginMainPageContext SetupView - NowTimeStamp:1697579208
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity : [2023-10-18 05:46:49.333] On Mobile Platform, FSR quality
      is fixed on FLOAT16MOBILE
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity :
      UnityEngine.Rendering.PostProcessing.PostProcessLayer:OnEnable()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.333 23548 23614 I Unity : UnityEngine.Object:Internal_CloneSingle(Object)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity : UnityEngine.Object:Instantiate(T)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity :
      MoleMole.StatExtension:Instantiate(T)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I
      Unity : MoleMole.MonoLoginScene:Awake()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I
      Unity : UnityEngine.Object:Instantiate(Object, Transform, Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.333 23548 23614 I Unity : UnityEngine.Object:Instantiate(T, Transform)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity : MoleMole.StatExtension:Instantiate(T,
      Transform)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity :
      NKMBPJJPGEF:NLBBIPMBEAH()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity :
      NKMBPJJPGEF:SetupView()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity :
      MoleMole.BaseContext:Setup()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity :
      HLFIMACGGAA:OnLoadedView(GameObject)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity
      : System.Action`1:Invoke(T)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity :
      System.Action`1:Invoke(T)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity :
      JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG, GameObject, Action`1)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.333 23548 23614 I Unity : JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG, Action`1, Boolean,
      BaseContext)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity :
      GPMBIMCJPFC:LCDDBGAEMHI(BaseContext, Action`1, Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333
      23548 23614 I Unity : HLFIMACGGAA:Init()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I
      Unity : GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.333 23548 23614 I Unity : GPMBIMCJPFC:AONNCDKCNFG(WorldType, Boolean)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity : OLHIFOGGMIM:MoveNext()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity : UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator,
      IntPtr)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.333 23548 23614 I Unity : (Filena
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.337 23548 23614 W Unity : [2023-10-18 05:46:49.337] Checkboard Setting: None
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity : MoleMole.MonoLoginScene:Awake()
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity : UnityEngine.Object:Instantiate(Object, Transform,
      Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity :
      UnityEngine.Object:Instantiate(T, Transform)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.337 23548 23614
      W Unity : MoleMole.StatExtension:Instantiate(T, Transform)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.337 23548 23614 W Unity : NKMBPJJPGEF:NLBBIPMBEAH()
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.337 23548 23614 W Unity : NKMBPJJPGEF:SetupView()
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.337 23548 23614 W Unity : MoleMole.BaseContext:Setup()
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.337 23548 23614 W Unity : HLFIMACGGAA:OnLoadedView(GameObject)
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity : System.Action`1:Invoke(T)
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity : System.Action`1:Invoke(T)
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity : JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG, GameObject,
      Action`1)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity :
      JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.337 23548 23614 W Unity : GPMBIMCJPFC:LCDDBGAEMHI(BaseContext, Action`1, Boolean)
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity : HLFIMACGGAA:Init()
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity : GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA, Boolean,
      LEHAGMFMNLH)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity :
      GPMBIMCJPFC:AONNCDKCNFG(WorldType, Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.337 23548 23614
      W Unity : OLHIFOGGMIM:MoveNext()
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity :
      UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.337 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity :
      (Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line:
      64)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.337 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity : [2023-10-18 05:46:49.339] On Mobile Platform, FSR quality
      is fixed on FLOAT16MOBILE
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity :
      MEGHBLMAFHN:GMNJPNCOKJF(Camera, Boolean, HHBHHDMINPG, Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.339 23548 23614 I Unity : MoleMole.MonoLoginScene:DGGPJOJAOCN(Camera)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity : MoleMole.MonoLoginScene:Awake()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity : UnityEngine.Object:Instantiate(Object, Transform,
      Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity :
      UnityEngine.Object:Instantiate(T, Transform)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.339 23548 23614
      I Unity : MoleMole.StatExtension:Instantiate(T, Transform)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.339 23548 23614 I Unity : NKMBPJJPGEF:NLBBIPMBEAH()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.339 23548 23614 I Unity : NKMBPJJPGEF:SetupView()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.339 23548 23614 I Unity : MoleMole.BaseContext:Setup()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.339 23548 23614 I Unity : HLFIMACGGAA:OnLoadedView(GameObject)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity : System.Action`1:Invoke(T)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity : System.Action`1:Invoke(T)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity : JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG, GameObject,
      Action`1)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity :
      JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.339 23548 23614 I Unity : GPMBIMCJPFC:LCDDBGAEMHI(BaseContext, Action`1, Boolean)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity : HLFIMACGGAA:Init()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity : GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA, Boolean,
      LEHAGMFMNLH)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity :
      GPMBIMCJPFC:AONNCDKCNFG(WorldType, Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.339 23548 23614
      I Unity : OLHIFOGGMIM:MoveNext()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity :
      UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.339 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.339 23548 23614 I Unity :
      (Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindin
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity : [2023-10-18 05:46:49.344] Texture streaming preload
      close!
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity :
      MoleMole.MonoLoginScene:Awake()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity :
      UnityEngine.Object:Instantiate(Object, Transform, Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.344 23548 23614 I Unity : UnityEngine.Object:Instantiate(T, Transform)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity : MoleMole.StatExtension:Instantiate(T,
      Transform)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity :
      NKMBPJJPGEF:NLBBIPMBEAH()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity :
      NKMBPJJPGEF:SetupView()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity :
      MoleMole.BaseContext:Setup()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity :
      HLFIMACGGAA:OnLoadedView(GameObject)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity
      : System.Action`1:Invoke(T)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity :
      System.Action`1:Invoke(T)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity :
      JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG, GameObject, Action`1)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.344 23548 23614 I Unity : JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG, Action`1, Boolean,
      BaseContext)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity :
      GPMBIMCJPFC:LCDDBGAEMHI(BaseContext, Action`1, Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344
      23548 23614 I Unity : HLFIMACGGAA:Init()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I
      Unity : GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.344 23548 23614 I Unity : GPMBIMCJPFC:AONNCDKCNFG(WorldType, Boolean)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity : OLHIFOGGMIM:MoveNext()
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity : UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator,
      IntPtr)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity : [ line 273]
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity : (Filename: Line: 273)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.344 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.346 23548 23614 W Unity : [2023-10-18 05:46:49.346] Checkboard Setting: None
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity : MoleMole.MonoLoginScene:Awake()
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity : UnityEngine.Object:Instantiate(Object, Transform,
      Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity :
      UnityEngine.Object:Instantiate(T, Transform)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.346 23548 23614
      W Unity : MoleMole.StatExtension:Instantiate(T, Transform)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.346 23548 23614 W Unity : NKMBPJJPGEF:NLBBIPMBEAH()
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.346 23548 23614 W Unity : NKMBPJJPGEF:SetupView()
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.346 23548 23614 W Unity : MoleMole.BaseContext:Setup()
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.346 23548 23614 W Unity : HLFIMACGGAA:OnLoadedView(GameObject)
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity : System.Action`1:Invoke(T)
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity : System.Action`1:Invoke(T)
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity : JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG, GameObject,
      Action`1)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity :
      JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.346 23548 23614 W Unity : GPMBIMCJPFC:LCDDBGAEMHI(BaseContext, Action`1, Boolean)
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity : HLFIMACGGAA:Init()
    </span>
    <br />
    <br />
    <span
      class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity : GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA, Boolean,
      LEHAGMFMNLH)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity :
      GPMBIMCJPFC:AONNCDKCNFG(WorldType, Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.346 23548 23614
      W Unity : OLHIFOGGMIM:MoveNext()
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity :
      UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18
      00:46:49.346 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity :
      (Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line:
      64)
    </span>
    <br />
    <br />
    <span class="terminal-yellow">10-18 00:46:49.346 23548 23614 W Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:49.458 23548 23614 I Unity : [2023-10-18 05:46:49.458] Genshin Start Log:
      LoginMainPageContext OnAgreement - NowTimeStamp:1697579209
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:49.514 23548 23614 I Unity : [2023-10-18 05:46:49.514] Genshin Start Log: LoginMainPageContext OnPreInit -
      NowTimeStamp:1697579209
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.176 23548 23614 I Unity :
      [2023-10-18 05:46:50.176] Genshin Start Log: LoginMainPageContext InitServerDispatch -
      NowTimeStamp:1697579210
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.176 23548 23614 I Unity :
      [2023-10-18 05:46:50.176] Genshin Start Log: NetworkManager ConnectGlobalDispatchServer 1 -
      NowTimeStamp:1697579210
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.176 23548 23614 I Unity :
      [2023-10-18 05:46:50.176] Genshin Start Log: NetworkManager ConnectGlobalDispatchServer
      https://dispatchosglobal.yuanshen.com/query_region_list - NowTimeStamp:1697579210
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:50.576 23548 23614 I Unity : [2023-10-18 05:46:50.576] Genshin Start Log:
      NetworkManager OnConnectGlobalDispatch - NowTimeStamp:1697579210
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:50.578 23548 23614 I Unity : [2023-10-18 05:46:50.578] Genshin Start Log: NetworkManager SetServerDispatchConfig
      isGlobal=True - NowTimeStamp:1697579210
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.581 23548 23614 I
      Unity : [2023-10-18 05:46:50.581] Set preload tick time scale to 1.000000
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:50.581 23548 23614 I Unity : CKOJLGMPICC:PAADLIHJLNL(JSONNode,
      Boolean)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.581 23548 23614 I Unity :
      LJINHHECAKE:NFJCJNGPJAC(Byte[], Byte[], CALMLBFFIMH)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.581
      23548 23614 I Unity : LJINHHECAKE:BIFMNBAPKOL(String, Action)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:50.581 23548 23614 I Unity : LBPBMNIPEDJ:MoveNext()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:50.581 23548 23614 I Unity : UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator,
      IntPtr)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.581 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:50.581 23548 23614 I Unity : [ line 68]
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:50.581 23548 23614 I Unity : (Filename: Line: 68)
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:50.581 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:50.582 23548 23614 I Unity : [2023-10-18 05:46:50.582] Wrote 0 persistent code switches
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:50.582 23548 23614 I Unity : LJINHHECAKE:BIFMNBAPKOL(String,
      Action)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.582 23548 23614 I Unity :
      LBPBMNIPEDJ:MoveNext()
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.582 23548 23614 I Unity :
      UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:50.582 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.582 23548 23614 I Unity :
      [ line 210]
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.582 23548 23614 I Unity : (Filename: Line:
      210)
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.582 23548 23614 I Unity :
    </span>
    <br />
    <br />
    <span
      class="terminal-green">10-18 00:46:50.593 23548 23614 I Unity : [2023-10-18 05:46:50.593] Genshin Start Log:
      LoginMainPageContext OnGlobalDP - NowTimeStamp:1697579210
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18
      00:46:50.621 23548 23614 I Unity : [2023-10-18 05:46:50.621] Genshin Start Log: LoginMainPageContext OnLogin -
      NowTimeStamp:1697579210
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:50.622 23548 23614 I Unity :
      [2023-10-18 05:46:50.622] Genshin Start Log: MiHoYoSDKManager SDKInit -
      NowTimeStamp:1697579210
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:51.064 23548 23614 I Unity :
      [2023-10-18 05:46:51.064] Genshin Start Log: LoginMainPageContext OnInitResponse -
      NowTimeStamp:1697579211
    </span>
    <br />
    <br />
    <span class="terminal-green">10-18 00:46:51.064 23548 23614 I Unity :
      [2023-10-18 05:46:51.064] Genshin Start Log: MiHoYoSDKManager SDKLogin - NowTimeStamp:1697579211
    </span>
  </div>
</details>

### Generic Colo**u**riser (aka `grc`)

#### Установка `grc`

```bash
sudo apt update && \
sudo apt install -y grc
```

#### Использование `grc`

```bash
grc adb logcat -s Unity
```

Да-да, `grc` не умеет работать через пайп.

#### Вывод `grc`

<details>
  <summary>Output of <code>grc</code></summary>

  <div class="container-log-fit">
    --------- beginning of main
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.633 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.627] UnityInitApplication
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.633 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.633] ApplicationModeVR
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.635 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.635] SetCurrentThreadAffinity
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.640 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.640] RuntimeInitialize
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.689 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.689] MountApk
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.721 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.721] MountObbs
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.723 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.723] MultiThreadStackTrace_Init
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.723 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.723] Signal handler for capture multi-threads stack register success!
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.724 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.724] MultiThreadStackTrace init success!
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.724 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.724] securitylib_Init
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.731 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.731] DeviceName
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.735 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.735] SystemInfo CPU = ARM64 FP ASIMD AES, Cores = 8, Memory = 5593mb
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.735 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.735] SystemInfo ARM big.LITTLE configuration: 0 big    <span class="terminal-blue">(mask: 0)
    </span>, 8 little    <span class="terminal-blue">(mask: 255)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.735 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.735] ApplicationInfo com.miHoYo.GenshinImpact version 4.1.0_18054760_18121248 build 6cd0a56d-433b-4312-b029-a27e8549f616
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:36
      </span>
    </b>.735 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:36
      </span>
    </b>.735] Built from '' branch, Version '2017.4.30f1    <span class="terminal-blue">(0)
    </span>', Build type 'Release', Scripting Backend 'il2cpp'
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:37
      </span>
    </b>.055 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:37
      </span>
    </b>.055] Read and enabled 0 persistent code switches
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:39
      </span>
    </b>.070 23548 23614 D Unity   :  GL_OES_EGL_image GL_OES_EGL_image_external GL_OES_EGL_sync GL_OES_vertex_half_float GL_OES_framebuffer_object GL_OES_rgb8_rgba8 GL_OES_compressed_ETC1_RGB8_texture GL_AMD_compressed_ATC_texture GL_KHR_texture_compression_astc_ldr GL_KHR_texture_compression_astc_hdr GL_OES_texture_compression_astc GL_OES_texture_npot GL_EXT_texture_filter_anisotropic GL_EXT_texture_format_BGRA8888 GL_EXT_read_format_bgra GL_OES_texture_3D GL_EXT_color_buffer_float GL_EXT_color_buffer_half_float GL_QCOM_alpha_test GL_OES_depth24 GL_OES_packed_depth_stencil GL_OES_depth_texture GL_OES_depth_texture_cube_map GL_EXT_sRGB GL_OES_texture_float GL_OES_texture_float_linear GL_OES_texture_half_float GL_OES_texture_half_float_linear GL_EXT_texture_type_2_10_10_10_REV GL_EXT_texture_sRGB_decode GL_EXT_texture_format_sRGB_override GL_OES_element_index_uint GL_EXT_copy_image GL_EXT_geometry_shader GL_EXT_tessellation_shader GL_OES_texture_stencil8 GL_EXT_shader_io_blocks GL_OES_shader_image_atomic GL_OES_sample_variables GL_EXT_texture_b
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:39
      </span>
    </b>.070 23548 23614 D Unity   : order_clamp GL_EXT_EGL_image_external_wrap_modes GL_EXT_multisampled_render_to_texture GL_EXT_multisampled_render_to_texture2 GL_OES_shader_multisample_interpolation GL_EXT_texture_cube_map_array GL_EXT_draw_buffers_indexed GL_EXT_gpu_shader5 GL_EXT_robustness GL_EXT_texture_buffer GL_EXT_shader_framebuffer_fetch GL_ARM_shader_framebuffer_fetch_depth_stencil GL_OES_texture_storage_multisample_2d_array GL_OES_sample_shading GL_OES_get_program_binary GL_EXT_debug_label GL_KHR_blend_equation_advanced GL_KHR_blend_equation_advanced_coherent GL_QCOM_tiled_rendering GL_ANDROID_extension_pack_es31a GL_EXT_primitive_bounding_box GL_OES_standard_derivatives GL_OES_vertex_array_object GL_EXT_disjoint_timer_query GL_KHR_debug GL_EXT_YUV_target GL_EXT_sRGB_write_control GL_EXT_texture_norm16 GL_EXT_discard_framebuffer GL_OES_surfaceless_context GL_OVR_multiview GL_OVR_multiview2 GL_EXT_texture_sRGB_R8 GL_KHR_no_error GL_EXT_debug_marker GL_OES_EGL_image_external_essl3 GL_OVR_multiview_multisampled_render_to_texture GL_E
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:39
      </span>
    </b>.070 23548 23614 D Unity   : XT_buffer_storage GL_EXT_external_buffer GL_EXT_blit_framebuffer_params GL_EXT_clip_cull_distance GL_EXT_protected_textures GL_EXT_shader_non_constant_global_initializers GL_QCOM_texture_foveated GL_QCOM_texture_foveated_subsampled_layout GL_QCOM_shader_framebuffer_fetch_noncoherent GL_QCOM_shader_framebuffer_fetch_rate GL_EXT_memory_object GL_EXT_memory_object_fd GL_EXT_EGL_image_array GL_NV_shader_noperspective_interpolation GL_KHR_robust_buffer_access_behavior GL_EXT_EGL_image_storage GL_EXT_blend_func_extended GL_EXT_clip_control GL_OES_texture_view GL_EXT_fragment_invocation_density GL_QCOM_validate_shader_binary GL_QCOM_YUV_texture_gather
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:39
      </span>
    </b>.074 23548 23614 E Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:39
      </span>
    </b>.074] HK4EUpload:Try to delete file
    <span class="terminal-blue"> /storage/emulated/0/Android/data/com.miHoYo.GenshinImpact/c124dfe0bc1c644acac37929fc0d8957_tmp
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:39
      </span>
    </b>.074 23548 23614 E Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:39
      </span>
    </b>.074 23548 23614 E Unity   :    <span class="terminal-blue">(Filename:  Line: 2233)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:39
      </span>
    </b>.074 23548 23614 E Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.304 23548 23614 W Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:40
      </span>
    </b>.304] Begin Compile ComputeShader
    <b>
      <span class="terminal-yellow">:B
      </span>
    </b>uildHIZ.HZBBuildCS
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.304 23548 23614 W Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.304 23548 23614 W Unity   :    <span class="terminal-blue">(Filename:  Line: 468)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.304 23548 23614 W Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.315 23548 23614 W Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:40
      </span>
    </b>.315] End Compile ComputeShader
    <b>
      <span class="terminal-yellow">:B
      </span>
    </b>uildHIZ.HZBBuildCS
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.315 23548 23614 W Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.315 23548 23614 W Unity   :    <span class="terminal-blue">(Filename:  Line: 500)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.315 23548 23614 W Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.316 23548 23614 W Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:40
      </span>
    </b>.316] Begin Compile ComputeShader
    <b>
      <span class="terminal-yellow">:B
      </span>
    </b>uildHIZ.HZBBuildCS
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.316 23548 23614 W Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.316 23548 23614 W Unity   :    <span class="terminal-blue">(Filename:  Line: 468)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.316 23548 23614 W Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.317 23548 23614 W Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:40
      </span>
    </b>.317] End Compile ComputeShader
    <b>
      <span class="terminal-yellow">:B
      </span>
    </b>uildHIZ.HZBBuildCS
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.317 23548 23614 W Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.317 23548 23614 W Unity   :    <span class="terminal-blue">(Filename:  Line: 500)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.317 23548 23614 W Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.317 23548 23614 W Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:40
      </span>
    </b>.317] Begin Compile ComputeShader
    <b>
      <span class="terminal-yellow">:B
      </span>
    </b>uildHIZ.HZBBuildCS
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.317 23548 23614 W Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.317 23548 23614 W Unity   :    <span class="terminal-blue">(Filename:  Line: 468)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.317 23548 23614 W Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.319 23548 23614 W Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:40
      </span>
    </b>.319] End Compile ComputeShader
    <b>
      <span class="terminal-yellow">:B
      </span>
    </b>uildHIZ.HZBBuildCS
    <br/>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.319 23548 23614 W Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.319 23548 23614 W Unity   :    <span class="terminal-blue">(Filename:  Line: 500)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.319 23548 23614 W Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.320 23548 23614 W Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:40
      </span>
    </b>.320] Begin Compile ComputeShader
    <b>
      <span class="terminal-yellow">:B
      </span>
    </b>uildHIZ.HZBBuildCS
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.320 23548 23614 W Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.320 23548 23614 W Unity   :    <span class="terminal-blue">(Filename:  Line: 468)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.320 23548 23614 W Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.321 23548 23614 W Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:40
      </span>
    </b>.321] End Compile ComputeShader
    <b>
      <span class="terminal-yellow">:B
      </span>
    </b>uildHIZ.HZBBuildCS
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.321 23548 23614 W Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.321 23548 23614 W Unity   :    <span class="terminal-blue">(Filename:  Line: 500)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:40
      </span>
    </b>.321 23548 23614 W Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.508 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:43
      </span>
    </b>.508] Genshin Start Log: GameManager Awake - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579203
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.550 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:43
      </span>
    </b>.549] Genshin Start Log: GameManager Start - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579203
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.550 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:43
      </span>
    </b>.550] Genshin Start Log: GameManager InitGame - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579203
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.565 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:43
      </span>
    </b>.565] Load DownloadPref: {
    <span class="terminal-blue">"resStatus"
    </span>:[0,0],
    <span class="terminal-blue">"redownloadUselessAudio"
    </span>
    <b>
      <span class="terminal-yellow">:fa
      </span>
    </b>lse,
    <span class="terminal-blue">"redownloadUselessVideo"
    </span>
    <b>
      <span class="terminal-yellow">:fa
      </span>
    </b>lse}
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.565 23548 23614 I Unity   : DJMNDPNJCKD:OMMJEAGFEBP
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.565 23548 23614 I Unity   : MoleMole.GameManager:HOOLDBCLMMF
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.565 23548 23614 I Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.565 23548 23614 I Unity   :    <span class="terminal-blue">(Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.565 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.578 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:43
      </span>
    </b>.578] IsBaseResVersionHashChanged=> baseResVersionHashInPersist = b8ad419157e6112db0fc9fb117ef4a9f, md5 in streamingResVersion = b8ad419157e6112db0fc9fb117ef4a9f
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.578 23548 23614 I Unity   : MoleMole.GameManager:HOOLDBCLMMF
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.578 23548 23614 I Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.578 23548 23614 I Unity   :    <span class="terminal-blue">(Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:43
      </span>
    </b>.578 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:44
      </span>
    </b>.791 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:44
      </span>
    </b>.791] [MTRManager]client create sucess!
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:44
      </span>
    </b>.791 23548 23614 I Unity   : MoleMole.GameManager
    <b>
      <span class="terminal-yellow">:AE
      </span>
    </b>HPIEMNCIN
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:44
      </span>
    </b>.791 23548 23614 I Unity   : MoleMole.GameManager:HOOLDBCLMMF
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:44
      </span>
    </b>.791 23548 23614 I Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:44
      </span>
    </b>.791 23548 23614 I Unity   :    <span class="terminal-blue">(Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:44
      </span>
    </b>.791 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:44
      </span>
    </b>.826 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:44
      </span>
    </b>.826] Genshin Start Log: GameManager ShowLogo - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579204
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:44
      </span>
    </b>.888 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:44
      </span>
    </b>.888] Genshin Start Log: LogoPageContext SetupView - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579204
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.884 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:47
      </span>
    </b>.884] Genshin Start Log: LogoPageContext ClosePage - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579207
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.884 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:47
      </span>
    </b>.884] Genshin Start Log: GameManager StartHome - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579207
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.916 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:47
      </span>
    </b>.916] Genshin Start Log: GameManager ChangeGameWorld Home - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579207
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.924 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:47
      </span>
    </b>.924] Genshin Start Log: GameManager CreateNewGameWorld Home - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579207
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.939 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:47
      </span>
    </b>.939] Genshin Start Log: Home LoadScene - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579207
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:47
      </span>
    </b>.961] Texture streaming preload close!
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : OLHIFOGGMIM:MoveNext
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : UnityEngine.SetupCoroutine:InvokeMoveNext
    <span class="terminal-blue">(IEnumerator, IntPtr)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : UnityEngine.MonoBehaviour:StartCoroutine
    <span class="terminal-blue">(IEnumerator)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : JBLGLCLGBK
    <b>
      <span class="terminal-yellow">E:C
      </span>
    </b>IIBFDCPMNB
    <span class="terminal-blue">(IEnumerator, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : AEJMFLHFEPL:ILMJEICJEOM
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : MoleMole.GameManager:KPHEGEBOONL
    <span class="terminal-blue">(WorldType, UInt32, String, String)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : MoleMole.EEGFAFEFKOC:LLDKNDHIIIH
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : JFONKPLEEGN:Invoke
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : HKELOMNMLFL:Tick
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : MoleMole.GameManager:ONCKPFPBFNI
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : MoleMole.GameManager:Update
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : [ line 273] 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   :    <span class="terminal-blue">(Filename:  Line: 273)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.961 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:47
      </span>
    </b>.961] Genshin Start Log: GameManager FirstChangeToHomeCallback - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579207
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:47
      </span>
    </b>.966] Texture streaming preload close!
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : KAEEPNKKCDK:JKANBEOJLHH
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : MoleMole.GameManager
    <b>
      <span class="terminal-yellow">:AB
      </span>
    </b>JOLHANEPM
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : System.Action:Invoke
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : MoleMole.EEGFAFEFKOC:LLDKNDHIIIH
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : JFONKPLEEGN:Invoke
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : HKELOMNMLFL:Tick
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : MoleMole.GameManager:ONCKPFPBFNI
    <span class="terminal-blue">()
    </span>
    <br/>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : MoleMole.GameManager:Update
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : [ line 273] 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   :    <span class="terminal-blue">(Filename:  Line: 273)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:47
      </span>
    </b>.966 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:48
      </span>
    </b>.393 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:48
      </span>
    </b>.393] Genshin Start Log: LoginMainPageContext SetupView - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579208
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:49
      </span>
    </b>.333] On Mobile Platform, FSR quality is fixed on FLOAT16MOBILE
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : UnityEngine.Rendering.PostProcessing.PostProcessLayer:OnEnable
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : UnityEngine.Object:Internal_CloneSingle
    <span class="terminal-blue">(Object)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : UnityEngine.Object:Instantiate
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : MoleMole.StatExtension:Instantiate
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : MoleMole.MonoLoginScen
    <b>
      <span class="terminal-yellow">e:A
      </span>
    </b>wake
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : UnityEngine.Object:Instantiate
    <span class="terminal-blue">(Object, Transform, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : UnityEngine.Object:Instantiate
    <span class="terminal-blue">(T, Transform)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : MoleMole.StatExtension:Instantiate
    <span class="terminal-blue">(T, Transform)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : NKMBPJJPGEF:NLBBIPMBEAH
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : NKMBPJJPGEF:SetupView
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : MoleMole.BaseContext:Setup
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : HLFIMACGGAA:OnLoadedView
    <span class="terminal-blue">(GameObject)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : System.Action`1:Invoke
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : System.Action`1:Invoke
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : JFNKFMBKNBE:HLNJKMGFMFM
    <span class="terminal-blue">(MKNNHKMPCOG, GameObject, Action`1)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : JFNKFMBKNBE:OPKLNDPCFBJ
    <span class="terminal-blue">(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : GPMBIMCJPFC:LCDDBGAEMHI
    <span class="terminal-blue">(BaseContext, Action`1, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : HLFIMACGGAA:Init
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : GPMBIMCJPFC:JMLINLCCOFM
    <span class="terminal-blue">(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : GPMBIMCJP
    <b>
      <span class="terminal-yellow">FC:A
      </span>
    </b>ONNCDKCNFG
    <span class="terminal-blue">(WorldType, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : OLHIFOGGMIM:MoveNext
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : UnityEngine.SetupCoroutine:InvokeMoveNext
    <span class="terminal-blue">(IEnumerator, IntPtr)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.333 23548 23614 I Unity   : (Filena
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:49
      </span>
    </b>.337] Checkboard Setting: None
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : MoleMole.MonoLoginScen
    <b>
      <span class="terminal-yellow">e:A
      </span>
    </b>wake
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : UnityEngine.Object:Instantiate
    <span class="terminal-blue">(Object, Transform, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : UnityEngine.Object:Instantiate
    <span class="terminal-blue">(T, Transform)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : MoleMole.StatExtension:Instantiate
    <span class="terminal-blue">(T, Transform)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : NKMBPJJPGEF:NLBBIPMBEAH
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : NKMBPJJPGEF:SetupView
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : MoleMole.BaseContext:Setup
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : HLFIMACGGAA:OnLoadedView
    <span class="terminal-blue">(GameObject)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : System.Action`1:Invoke
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : System.Action`1:Invoke
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : JFNKFMBKNBE:HLNJKMGFMFM
    <span class="terminal-blue">(MKNNHKMPCOG, GameObject, Action`1)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : JFNKFMBKNBE:OPKLNDPCFBJ
    <span class="terminal-blue">(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : GPMBIMCJPFC:LCDDBGAEMHI
    <span class="terminal-blue">(BaseContext, Action`1, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : HLFIMACGGAA:Init
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : GPMBIMCJPFC:JMLINLCCOFM
    <span class="terminal-blue">(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : GPMBIMCJP
    <b>
      <span class="terminal-yellow">FC:A
      </span>
    </b>ONNCDKCNFG
    <span class="terminal-blue">(WorldType, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : OLHIFOGGMIM:MoveNext
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : UnityEngine.SetupCoroutine:InvokeMoveNext
    <span class="terminal-blue">(IEnumerator, IntPtr)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   :    <span class="terminal-blue">(Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.337 23548 23614 W Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:49
      </span>
    </b>.339] On Mobile Platform, FSR quality is fixed on FLOAT16MOBILE
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : MEGHBLMAFHN:GMNJPNCOKJF
    <span class="terminal-blue">(Camera, Boolean, HHBHHDMINPG, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : MoleMole.MonoLoginScen
    <b>
      <span class="terminal-yellow">e:D
      </span>
    </b>GGPJOJAOCN
    <span class="terminal-blue">(Camera)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : MoleMole.MonoLoginScen
    <b>
      <span class="terminal-yellow">e:A
      </span>
    </b>wake
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : UnityEngine.Object:Instantiate
    <span class="terminal-blue">(Object, Transform, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : UnityEngine.Object:Instantiate
    <span class="terminal-blue">(T, Transform)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : MoleMole.StatExtension:Instantiate
    <span class="terminal-blue">(T, Transform)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : NKMBPJJPGEF:NLBBIPMBEAH
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : NKMBPJJPGEF:SetupView
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : MoleMole.BaseContext:Setup
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : HLFIMACGGAA:OnLoadedView
    <span class="terminal-blue">(GameObject)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : System.Action`1:Invoke
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : System.Action`1:Invoke
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : JFNKFMBKNBE:HLNJKMGFMFM
    <span class="terminal-blue">(MKNNHKMPCOG, GameObject, Action`1)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : JFNKFMBKNBE:OPKLNDPCFBJ
    <span class="terminal-blue">(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
    </span>
    <br/>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : GPMBIMCJPFC:LCDDBGAEMHI
    <span class="terminal-blue">(BaseContext, Action`1, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : HLFIMACGGAA:Init
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : GPMBIMCJPFC:JMLINLCCOFM
    <span class="terminal-blue">(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : GPMBIMCJP
    <b>
      <span class="terminal-yellow">FC:A
      </span>
    </b>ONNCDKCNFG
    <span class="terminal-blue">(WorldType, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : OLHIFOGGMIM:MoveNext
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : UnityEngine.SetupCoroutine:InvokeMoveNext
    <span class="terminal-blue">(IEnumerator, IntPtr)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.339 23548 23614 I Unity   : (Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindin
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:49
      </span>
    </b>.344] Texture streaming preload close!
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : MoleMole.MonoLoginScen
    <b>
      <span class="terminal-yellow">e:A
      </span>
    </b>wake
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : UnityEngine.Object:Instantiate
    <span class="terminal-blue">(Object, Transform, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : UnityEngine.Object:Instantiate
    <span class="terminal-blue">(T, Transform)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : MoleMole.StatExtension:Instantiate
    <span class="terminal-blue">(T, Transform)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : NKMBPJJPGEF:NLBBIPMBEAH
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : NKMBPJJPGEF:SetupView
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : MoleMole.BaseContext:Setup
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : HLFIMACGGAA:OnLoadedView
    <span class="terminal-blue">(GameObject)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : System.Action`1:Invoke
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : System.Action`1:Invoke
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : JFNKFMBKNBE:HLNJKMGFMFM
    <span class="terminal-blue">(MKNNHKMPCOG, GameObject, Action`1)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : JFNKFMBKNBE:OPKLNDPCFBJ
    <span class="terminal-blue">(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : GPMBIMCJPFC:LCDDBGAEMHI
    <span class="terminal-blue">(BaseContext, Action`1, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : HLFIMACGGAA:Init
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : GPMBIMCJPFC:JMLINLCCOFM
    <span class="terminal-blue">(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : GPMBIMCJP
    <b>
      <span class="terminal-yellow">FC:A
      </span>
    </b>ONNCDKCNFG
    <span class="terminal-blue">(WorldType, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : OLHIFOGGMIM:MoveNext
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : UnityEngine.SetupCoroutine:InvokeMoveNext
    <span class="terminal-blue">(IEnumerator, IntPtr)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : [ line 273] 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   :    <span class="terminal-blue">(Filename:  Line: 273)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.344 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:49
      </span>
    </b>.346] Checkboard Setting: None
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : MoleMole.MonoLoginScen
    <b>
      <span class="terminal-yellow">e:A
      </span>
    </b>wake
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : UnityEngine.Object:Instantiate
    <span class="terminal-blue">(Object, Transform, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : UnityEngine.Object:Instantiate
    <span class="terminal-blue">(T, Transform)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : MoleMole.StatExtension:Instantiate
    <span class="terminal-blue">(T, Transform)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : NKMBPJJPGEF:NLBBIPMBEAH
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : NKMBPJJPGEF:SetupView
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : MoleMole.BaseContext:Setup
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : HLFIMACGGAA:OnLoadedView
    <span class="terminal-blue">(GameObject)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : System.Action`1:Invoke
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : System.Action`1:Invoke
    <span class="terminal-blue">(T)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : JFNKFMBKNBE:HLNJKMGFMFM
    <span class="terminal-blue">(MKNNHKMPCOG, GameObject, Action`1)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : JFNKFMBKNBE:OPKLNDPCFBJ
    <span class="terminal-blue">(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : GPMBIMCJPFC:LCDDBGAEMHI
    <span class="terminal-blue">(BaseContext, Action`1, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : HLFIMACGGAA:Init
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : GPMBIMCJPFC:JMLINLCCOFM
    <span class="terminal-blue">(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : GPMBIMCJP
    <b>
      <span class="terminal-yellow">FC:A
      </span>
    </b>ONNCDKCNFG
    <span class="terminal-blue">(WorldType, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : OLHIFOGGMIM:MoveNext
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : UnityEngine.SetupCoroutine:InvokeMoveNext
    <span class="terminal-blue">(IEnumerator, IntPtr)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   :  
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   :    <span class="terminal-blue">(Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.346 23548 23614 W Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.458 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:49
      </span>
    </b>.458] Genshin Start Log: LoginMainPageContext OnAgreement - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579209
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:49
      </span>
    </b>.514 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:49
      </span>
    </b>.514] Genshin Start Log: LoginMainPageContext OnPreInit - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579209
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.176 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:50
      </span>
    </b>.176] Genshin Start Log: LoginMainPageContext InitServerDispatch - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579210
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.176 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:50
      </span>
    </b>.176] Genshin Start Log: NetworkManager ConnectGlobalDispatchServer 1 - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579210
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.176 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:50
      </span>
    </b>.176] Genshin Start Log: NetworkManager ConnectGlobalDispatchServer https://dispatchosglobal.yuanshen.com/query_region_list - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579210
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.576 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:50
      </span>
    </b>.576] Genshin Start Log: NetworkManager OnConnectGlobalDispatch - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579210
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.578 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:50
      </span>
    </b>.578] Genshin Start Log: NetworkManager SetServerDispatchConfig isGlobal=True - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579210
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.581 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:50
      </span>
    </b>.581] Set preload tick time scale to 1.000000
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.581 23548 23614 I Unity   : CKOJLGMPICC:PAADLIHJLNL
    <span class="terminal-blue">(JSONNode, Boolean)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.581 23548 23614 I Unity   : LJINHHECAKE:NFJCJNGPJAC
    <span class="terminal-blue">(Byte[], Byte[], CALMLBFFIMH)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.581 23548 23614 I Unity   : LJINHHECAK
    <b>
      <span class="terminal-yellow">E:B
      </span>
    </b>IFMNBAPKOL
    <span class="terminal-blue">(String, Action)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.581 23548 23614 I Unity   : LBPBMNIPEDJ:MoveNext
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.581 23548 23614 I Unity   : UnityEngine.SetupCoroutine:InvokeMoveNext
    <span class="terminal-blue">(IEnumerator, IntPtr)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.581 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.581 23548 23614 I Unity   : [ line 68] 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.581 23548 23614 I Unity   :    <span class="terminal-blue">(Filename:  Line: 68)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.581 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.582 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:50
      </span>
    </b>.582] Wrote 0 persistent code switches
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.582 23548 23614 I Unity   : LJINHHECAK
    <b>
      <span class="terminal-yellow">E:B
      </span>
    </b>IFMNBAPKOL
    <span class="terminal-blue">(String, Action)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.582 23548 23614 I Unity   : LBPBMNIPEDJ:MoveNext
    <span class="terminal-blue">()
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.582 23548 23614 I Unity   : UnityEngine.SetupCoroutine:InvokeMoveNext
    <span class="terminal-blue">(IEnumerator, IntPtr)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.582 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.582 23548 23614 I Unity   : [ line 210] 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.582 23548 23614 I Unity   :    <span class="terminal-blue">(Filename:  Line: 210)
    </span>
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.582 23548 23614 I Unity   : 
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.593 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:50
      </span>
    </b>.593] Genshin Start Log: LoginMainPageContext OnGlobalDP - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579210
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.621 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:50
      </span>
    </b>.621] Genshin Start Log: LoginMainPageContext OnLogin - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579210
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:50
      </span>
    </b>.622 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:50
      </span>
    </b>.622] Genshin Start Log: MiHoYoSDKManager SDKInit - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579210
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:51
      </span>
    </b>.064 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:51
      </span>
    </b>.064] Genshin Start Log: LoginMainPageContext OnInitResponse - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579211
    <br/>10-18 
    <b>
      <span class="terminal-yellow">00:46:51
      </span>
    </b>.064 23548 23614 I Unity   : [2023-10-18 
    <b>
      <span class="terminal-yellow">05:46:51
      </span>
    </b>.064] Genshin Start Log: MiHoYoSDKManager SDKLogin - NowTimeStamp
    <b>
      <span class="terminal-yellow">:1697
      </span>
    </b>579211
  </div>
</details>

### `ccze`

#### Установка `ccze`

```bash
sudo apt update && \
sudo apt install -y ccze
```

#### Использование `ccze`

```bash
adb logcat -s Unity | ccze -A
```

#### Вывод `ccze`

<details>
  <summary>Output of <code>ccze</code></summary>

  <div class="container-log-fit">
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ---------
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        beginning
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        of
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        main
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.633
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.627
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityInitApplication
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.633
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.633
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ApplicationModeVR
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.635
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.635
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        SetCurrentThreadAffinity
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.640
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.640
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        RuntimeInitialize
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.689
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.689
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MountApk
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.721
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.721
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MountObbs
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.723
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.723
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MultiThreadStackTrace_Init
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.723
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.723
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Signal
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        handler
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        for
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        capture
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        multi-threads
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        stack
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          register
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        success
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">!
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.724
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.724
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MultiThreadStackTrace
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        init
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        success
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">!
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.724
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.724
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        securitylib_Init
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.731
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.731
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        DeviceName
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.735
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.735
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        SystemInfo
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          CPU
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        =
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ARM64
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        FP
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ASIMD
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        AES
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Cores
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        =
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        8
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Memory
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        =
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-white">
          5593mb
        </span>
      </b>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.735
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.735
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        SystemInfo
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ARM
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        big.LITTLE
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        configuration
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        0
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        big
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">mask
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        0
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">),
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        8
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        little
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">mask
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        255
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.735
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.735
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ApplicationInfo
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        com.miHoYo.GenshinImpact
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        version
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        4.1.0_18054760_18121248
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        build
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        6cd0a56d-433b-4312-b029-a27e8549f616
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:36.735
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:36.735
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Built
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        from
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ''
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        branch
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Version
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        '
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-white">2017.4.30f1
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">0
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)',
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Build
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        type
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        '
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Release
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">',
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Scripting
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Backend
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        '
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">il2cpp
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">'
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:37.055
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:37.055
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Read
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        and
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          enabled
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        0
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        persistent
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        code
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        switches
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:39.070
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        D
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_EGL_image
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_EGL_image_external
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_EGL_sync
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_vertex_half_float
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_framebuffer_object
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_rgb8_rgba8
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_compressed_ETC1_RGB8_texture
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_AMD_compressed_ATC_texture
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_KHR_texture_compression_astc_ldr
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_KHR_texture_compression_astc_hdr
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_texture_compression_astc
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_texture_npot
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_texture_filter_anisotropic
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_texture_format_BGRA8888
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_read_format_bgra
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_texture_3D
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_color_buffer_float
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_color_buffer_half_float
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_QCOM_alpha_test
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_depth24
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_packed_depth_stencil
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_depth_texture
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_depth_texture_cube_map
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_sRGB
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_texture_float
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_texture_float_linear
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_texture_half_float
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_texture_half_float_linear
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_texture_type_2_10_10_10_REV
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_texture_sRGB_decode
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_texture_format_sRGB_override
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_element_index_uint
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_copy_image
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_geometry_shader
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_tessellation_shader
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_texture_stencil8
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_shader_io_blocks
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_shader_image_atomic
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_sample_variables
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_texture_b
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:39.070
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        D
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        order_clamp
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_EGL_image_external_wrap_modes
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_multisampled_render_to_texture
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_multisampled_render_to_texture2
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_shader_multisample_interpolation
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_texture_cube_map_array
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_draw_buffers_indexed
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_gpu_shader5
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_robustness
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_texture_buffer
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_shader_framebuffer_fetch
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_ARM_shader_framebuffer_fetch_depth_stencil
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_texture_storage_multisample_2d_array
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_sample_shading
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_get_program_binary
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_debug_label
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_KHR_blend_equation_advanced
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_KHR_blend_equation_advanced_coherent
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_QCOM_tiled_rendering
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_ANDROID_extension_pack_es31a
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_primitive_bounding_box
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_standard_derivatives
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_vertex_array_object
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_disjoint_timer_query
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_KHR_debug
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_YUV_target
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_sRGB_write_control
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_texture_norm16
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_discard_framebuffer
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_surfaceless_context
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OVR_multiview
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OVR_multiview2
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_texture_sRGB_R8
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_KHR_no_error
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_debug_marker
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_EGL_image_external_essl3
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OVR_multiview_multisampled_render_to_texture
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_E
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:39.070
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        D
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        XT_buffer_storage
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_external_buffer
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_blit_framebuffer_params
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_clip_cull_distance
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_protected_textures
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_shader_non_constant_global_initializers
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_QCOM_texture_foveated
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_QCOM_texture_foveated_subsampled_layout
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_QCOM_shader_framebuffer_fetch_noncoherent
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_QCOM_shader_framebuffer_fetch_rate
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_memory_object
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_memory_object_fd
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_EGL_image_array
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_NV_shader_noperspective_interpolation
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_KHR_robust_buffer_access_behavior
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_EGL_image_storage
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_blend_func_extended
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_clip_control
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_OES_texture_view
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_EXT_fragment_invocation_density
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_QCOM_validate_shader_binary
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GL_QCOM_YUV_texture_gather
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:39.074
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        E
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:39.074
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HK4EUpload:Try
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        to
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        delete
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        file
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          /storage/emulated/0/Android/data/com.miHoYo.GenshinImpact/c124dfe0bc1c644acac37929fc0d8957_tmp
        </span>
      </b>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:39.074
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        E
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:39.074
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        E
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        2233
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:39.074
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        E
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.304
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:40.304
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Begin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Compile
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.304
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.304
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        468
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.304
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.315
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:40.315
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-yellow">
          End
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Compile
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.315
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.315
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        500
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.315
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.316
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:40.316
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Begin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Compile
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.316
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.316
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        468
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.316
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.317
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:40.317
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-yellow">
          End
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Compile
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.317
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.317
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        500
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.317
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.317
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:40.317
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Begin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Compile
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.317
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.317
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        468
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.317
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.319
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:40.319
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-yellow">
          End
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Compile
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.319
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.319
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        500
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.319
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.320
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:40.320
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Begin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Compile
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.320
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.320
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        468
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.320
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.321
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:40.321
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-yellow">
          End
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Compile
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.321
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.321
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        500
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:40.321
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.508
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:43.508
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Awake
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579203
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.550
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:43.549
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579203
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.550
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:43.550
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        InitGame
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579203
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.565
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:43.565
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Load
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-yellow">
          DownloadPref
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        {"
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">resStatus":[0,0],"redownloadUselessAudio":false,"redownloadUselessVideo":false
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">}
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.565
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        DJMNDPNJCKD:OMMJEAGFEBP(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.565
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.GameManager:HOOLDBCLMMF(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.565
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.565
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        64
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.565
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.578
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:43.578
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        IsBaseResVersionHashChanged=
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">&gt;
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        baseResVersionHashInPersist
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        =
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        b8ad419157e6112db0fc9fb117ef4a9f
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        md5
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        in
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        streamingResVersion
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        =
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        b8ad419157e6112db0fc9fb117ef4a9f
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.578
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.GameManager:HOOLDBCLMMF(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.578
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.578
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        64
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:43.578
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:44.791
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:44.791
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">MTRManager]client
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        create
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        sucess
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">!
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:44.791
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.GameManager:AEHPIEMNCIN(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:44.791
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.GameManager:HOOLDBCLMMF(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:44.791
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:44.791
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">6m:
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        64
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:44.791
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:44.826
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:44.826
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ShowLogo
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579204
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:44.888
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:44.888
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LogoPageContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        SetupView
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579204
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.884
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:47.884
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LogoPageContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-yellow">
          ClosePage
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579207
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.884
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:47.884
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          StartHome
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579207
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.916
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:47.916
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        ChangeGameWorld
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Home
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579207
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.924
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:47.924
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        CreateNewGameWorld
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Home
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579207
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.939
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:47.939
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Home
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          LoadScene
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579207
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Texture
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        streaming
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        preload
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-yellow">
          close
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">!
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OLHIFOGGMIM:MoveNext(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        IntPtr
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.MonoBehaviour:StartCoroutine(IEnumerator
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JBLGLCLGBKE:CIIBFDCPMNB(IEnumerator
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        AEJMFLHFEPL:ILMJEICJEOM(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.GameManager:KPHEGEBOONL(WorldType
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UInt32
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        String
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        String
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.EEGFAFEFKOC:LLDKNDHIIIH(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFONKPLEEGN:Invoke(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HKELOMNMLFL:Tick(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.GameManager:ONCKPFPBFNI(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.GameManager:Update(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        273
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        273
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:47.961
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        FirstChangeToHomeCallback
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579207
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Texture
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        streaming
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        preload
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-yellow">
          close
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">!
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        KAEEPNKKCDK:JKANBEOJLHH(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.GameManager:ABJOLHANEPM(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        System.Action:Invoke(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.EEGFAFEFKOC:LLDKNDHIIIH(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFONKPLEEGN:Invoke(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HKELOMNMLFL:Tick(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.GameManager:ONCKPFPBFNI(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.GameManager:Update(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        273
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        273
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:47.966
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:48.393
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:48.393
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LoginMainPageContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        SetupView
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579208
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        On
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Mobile
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Platform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        FSR
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        quality
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        is
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        fixed
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        on
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        FLOAT16MOBILE
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Rendering.PostProcessing.PostProcessLayer:OnEnable(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Internal_CloneSingle(Object
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.StatExtension:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.MonoLoginScene:Awake(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Instantiate(Object
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.StatExtension:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NKMBPJJPGEF:NLBBIPMBEAH(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NKMBPJJPGEF:SetupView(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.BaseContext:Setup(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HLFIMACGGAA:OnLoadedView(GameObject
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        System.Action`1:Invoke(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [0m
        <span style="font-weight:normal;text-decoration:none;font-style:normal">
          <b>
            <span class="terminal-cyan">00:46:49.333
            </span>
          </b>
        </span>
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        System.Action`1:Invoke(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameObject
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        BaseContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:LCDDBGAEMHI(BaseContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HLFIMACGGAA:Init(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LEHAGMFMNLH
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:AONNCDKCNFG(WorldType
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OLHIFOGGMIM:MoveNext(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        IntPtr
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">36m
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.333
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filena
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Checkboard
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Setting
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        None
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.MonoLoginScene:Awake(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Instantiate(Object
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.StatExtension:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NKMBPJJPGEF:NLBBIPMBEAH(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NKMBPJJPGEF:SetupView(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.BaseContext:Setup(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Uni
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">ty
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HLFIMACGGAA:OnLoadedView(GameObject
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        System.Action`1:Invoke(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        System.Action`1:Invoke(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameObject
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        BaseContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:LCDDBGAEMHI(BaseContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HLFIMACGGAA:Init(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LEHAGMFMNLH
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:AONNCDKCNFG(WorldType
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OLHIFOGGMIM:MoveNext(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">m
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        IntPtr
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        64
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.337
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        On
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Mobile
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Platform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        FSR
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        quality
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        is
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        fixed
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        on
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        FLOAT16MOBILE
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MEGHBLMAFHN:GMNJPNCOKJF(Camera
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HHBHHDMINPG
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.MonoLoginScene:DGGPJOJAOCN(Camera
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.MonoLoginScene:Awake(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Instantiate(Object
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">36mTransform
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.StatExtension:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NKMBPJJPGEF:NLBBIPMBEAH(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NKMBPJJPGEF:SetupView(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.BaseContext:Setup(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HLFIMACGGAA:OnLoadedView(GameObject
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        System.Action`1:Invoke(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        System.Action`1:Invoke(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameObject
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    [22m
    <span class="terminal-cyan">Boolean
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        BaseContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:LCDDBGAEMHI(BaseContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HLFIMACGGAA:Init(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LEHAGMFMNLH
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:AONNCDKCNFG(WorldType
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OLHIFOGGMIM:MoveNext(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        IntPtr
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.339
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindin
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Texture
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        streaming
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        preload
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-yellow">
          close
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">!
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        0m
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.MonoLoginScene:Awake(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Instantiate(Object
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.StatExtension:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NKMBPJJPGEF:NLBBIPMBEAH(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NKMBPJJPGEF:SetupView(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.BaseContext:Setup(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HLFIMACGGAA:OnLoadedView(GameObject
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        System.Action`1:Invoke(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        System.Action`1:Invoke(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameObject
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        BaseContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:LCDDBGAEMHI(BaseContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HLFIMACGGAA:Init(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LEHAGMFMNLH
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:AONNCDKCNFG(WorldType
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OLHIFOGGMIM:MoveNext(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        IntPtr
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        line
      </span>
    </span>22m
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        273
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        273
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.344
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Checkboard
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Setting
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        None
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.MonoLoginScene:Awake(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Instantiate(Object
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.Object:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.StatExtension:Instantiate(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Transform
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NKMBPJJPGEF:NLBBIPMBEAH(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NKMBPJJPGEF:SetupView(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Uni
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">ty
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MoleMole.BaseContext:Setup(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HLFIMACGGAA:OnLoadedView(GameObject
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        System.Action`1:Invoke(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        System.Action`1:Invoke(T
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GameObject
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        BaseContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:LCDDBGAEMHI(BaseContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action`1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        HLFIMACGGAA:Init(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LEHAGMFMNLH
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        GPMBIMCJPFC:AONNCDKCNFG(WorldType
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>2m
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OLHIFOGGMIM:MoveNext(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        IntPtr
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        64
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.346
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        W
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.458
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:49.458
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LoginMainPageContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OnAgreement
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579209
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:49.514
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:49.514
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LoginMainPageContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OnPreInit
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579209
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.176
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:50.176
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LoginMainPageContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        InitServerDispatch
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579210
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.176
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:50.176
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NetworkManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          ConnectGlobalDispatchServer
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        1
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579210
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.176
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:50.176
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NetworkManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          ConnectGlobalDispatchServer
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          https://dispatchosglobal.yuanshen.com/query_region_list
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579210
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.576
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:50.576
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NetworkManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OnConnectGlobalDispatch
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579210
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.578
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:50.578
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NetworkManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        SetServerDispatchConfig
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        isGlobal=True
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579210
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.581
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:50.581
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Set
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        preload
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        tick
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-purple">
          time
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        scale
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        to
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-white">
          1.000000
        </span>
      </b>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.581
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        CKOJLGMPICC:PAADLIHJLNL(JSO
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">NNode
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Boolean
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.581
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LJINHHECAKE:NFJCJNGPJAC(Byte[
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">],
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-blue">
          Byte
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">[
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">]
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        CALMLBFFIMH
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.581
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LJINHHECAKE:BIFMNBAPKOL(String
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.581
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LBPBMNIPEDJ:MoveNext(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.581
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        IntPtr
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.581
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.581
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        68
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.581
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        68
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.581
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.582
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:50.582
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Wrote
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        0
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        persistent
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        code
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        switches
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.582
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LJINHHECAKE:BIFMNBAPKOL(String
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Action
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.582
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LBPBMNIPEDJ:MoveNext(
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.582
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">,
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        IntPtr
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.582
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.582
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        210
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.582
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        (
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">Filename
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Line
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        210
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">)
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.582
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.593
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:50.593
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LoginMainPageContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OnGlobalDP
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579210
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.621
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:50.621
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LoginMainPageContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OnLogin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">36m
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579210
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:50.622
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:50.622
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MiHoYoSDKManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        SDKInit
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579210
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:51.064
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:51.064
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        LoginMainPageContext
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        OnInitResponse
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579211
      </span>
    </span>
    <br />
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          00:46:51.064
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23548
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-white">
        23614
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        I
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Unity
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        :
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        [
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">2023-10-18
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-cyan">
          05:46:51.064
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">]
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Genshin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <b>
        <span class="terminal-green">
          Start
        </span>
      </b>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        Log
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">:
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        MiHoYoSDKManager
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        SDKLogin
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        -
      </span>
    </span>
    <span style="font-weight:normal;text-decoration:none;font-style:normal">
      <span class="terminal-cyan">
        NowTimeStamp:1697579211
      </span>
    </span>
  </div>
</details>

### `logcat-colorize`

#### Установка `logcat-colorize`

```bash
sudo snap install logcat-colorize
```

#### Использование `logcat-colorize`

```bash
adb logcat -s Unity | logcat-colorize
```

#### Вывод `logcat-colorize`

<details>
  <summary>Output of <code>logcat-colorize</code></summary>

  <div class="container-log-fit">
    --------- beginning of main
    <br/>
    <br/>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.633 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.627] UnityInitApplication
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.633 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.633] ApplicationModeVR
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.635 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.635] SetCurrentThreadAffinity
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.640 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.640] RuntimeInitialize
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.689 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.689] MountApk
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.721 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.721] MountObbs
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.723 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.723] MultiThreadStackTrace_Init
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.723 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.723] Signal handler for capture multi-threads stack register success!
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.724 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.724] MultiThreadStackTrace init success!
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.724 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.724] securitylib_Init
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.731 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.731] DeviceName
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.735 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.735] SystemInfo CPU = ARM64 FP ASIMD AES, Cores = 8, Memory = 5593mb
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.735 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.735] SystemInfo ARM big.LITTLE configuration: 0 big (mask: 0), 8 little (mask: 255)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.735 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.735] ApplicationInfo com.miHoYo.GenshinImpact version 4.1.0_18054760_18121248 build 6cd0a56d-433b-4312-b029-a27e8549f616
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:36.735 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:36.735] Built from '' branch, Version '2017.4.30f1 (0)', Build type 'Release', Scripting Backend 'il2cpp'
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:37.055 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:37.055] Read and enabled 0 persistent code switches
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:39.070 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-blue">
            <span class="terminal-white"> D 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-blue"> GL_OES_EGL_image GL_OES_EGL_image_external GL_OES_EGL_sync GL_OES_vertex_half_float GL_OES_framebuffer_object GL_OES_rgb8_rgba8 GL_OES_compressed_ETC1_RGB8_texture GL_AMD_compressed_ATC_texture GL_KHR_texture_compression_astc_ldr GL_KHR_texture_compression_astc_hdr GL_OES_texture_compression_astc GL_OES_texture_npot GL_EXT_texture_filter_anisotropic GL_EXT_texture_format_BGRA8888 GL_EXT_read_format_bgra GL_OES_texture_3D GL_EXT_color_buffer_float GL_EXT_color_buffer_half_float GL_QCOM_alpha_test GL_OES_depth24 GL_OES_packed_depth_stencil GL_OES_depth_texture GL_OES_depth_texture_cube_map GL_EXT_sRGB GL_OES_texture_float GL_OES_texture_float_linear GL_OES_texture_half_float GL_OES_texture_half_float_linear GL_EXT_texture_type_2_10_10_10_REV GL_EXT_texture_sRGB_decode GL_EXT_texture_format_sRGB_override GL_OES_element_index_uint GL_EXT_copy_image GL_EXT_geometry_shader GL_EXT_tessellation_shader GL_OES_texture_stencil8 GL_EXT_shader_io_blocks GL_OES_shader_image_atomic GL_OES_sample_variables GL_EXT_texture_b
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:39.070 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-blue">
            <span class="terminal-white"> D 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-blue">order_clamp GL_EXT_EGL_image_external_wrap_modes GL_EXT_multisampled_render_to_texture GL_EXT_multisampled_render_to_texture2 GL_OES_shader_multisample_interpolation GL_EXT_texture_cube_map_array GL_EXT_draw_buffers_indexed GL_EXT_gpu_shader5 GL_EXT_robustness GL_EXT_texture_buffer GL_EXT_shader_framebuffer_fetch GL_ARM_shader_framebuffer_fetch_depth_stencil GL_OES_texture_storage_multisample_2d_array GL_OES_sample_shading GL_OES_get_program_binary GL_EXT_debug_label GL_KHR_blend_equation_advanced GL_KHR_blend_equation_advanced_coherent GL_QCOM_tiled_rendering GL_ANDROID_extension_pack_es31a GL_EXT_primitive_bounding_box GL_OES_standard_derivatives GL_OES_vertex_array_object GL_EXT_disjoint_timer_query GL_KHR_debug GL_EXT_YUV_target GL_EXT_sRGB_write_control GL_EXT_texture_norm16 GL_EXT_discard_framebuffer GL_OES_surfaceless_context GL_OVR_multiview GL_OVR_multiview2 GL_EXT_texture_sRGB_R8 GL_KHR_no_error GL_EXT_debug_marker GL_OES_EGL_image_external_essl3 GL_OVR_multiview_multisampled_render_to_texture GL_E
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:39.070 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-blue">
            <span class="terminal-white"> D 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-blue">XT_buffer_storage GL_EXT_external_buffer GL_EXT_blit_framebuffer_params GL_EXT_clip_cull_distance GL_EXT_protected_textures GL_EXT_shader_non_constant_global_initializers GL_QCOM_texture_foveated GL_QCOM_texture_foveated_subsampled_layout GL_QCOM_shader_framebuffer_fetch_noncoherent GL_QCOM_shader_framebuffer_fetch_rate GL_EXT_memory_object GL_EXT_memory_object_fd GL_EXT_EGL_image_array GL_NV_shader_noperspective_interpolation GL_KHR_robust_buffer_access_behavior GL_EXT_EGL_image_storage GL_EXT_blend_func_extended GL_EXT_clip_control GL_OES_texture_view GL_EXT_fragment_invocation_density GL_QCOM_validate_shader_binary GL_QCOM_YUV_texture_gather
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:39.074 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-red">
            <span class="terminal-white"> E 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-red">[2023-10-18 05:46:39.074] HK4EUpload:Try to delete file /storage/emulated/0/Android/data/com.miHoYo.GenshinImpact/c124dfe0bc1c644acac37929fc0d8957_tmp
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:39.074 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-red">
            <span class="terminal-white"> E 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-red"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:39.074 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-red">
            <span class="terminal-white"> E 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-red">(Filename:  Line: 2233)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:39.074 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-red">
            <span class="terminal-white"> E 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.304 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">[2023-10-18 05:46:40.304] Begin Compile ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.304 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.304 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">(Filename:  Line: 468)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.304 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.315 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">[2023-10-18 05:46:40.315] End Compile ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.315 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.315 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">(Filename:  Line: 500)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.315 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.316 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">[2023-10-18 05:46:40.316] Begin Compile ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.316 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.316 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">(Filename:  Line: 468)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.316 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.317 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">[2023-10-18 05:46:40.317] End Compile ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.317 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.317 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">(Filename:  Line: 500)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.317 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.317 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">[2023-10-18 05:46:40.317] Begin Compile ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.317 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.317 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">(Filename:  Line: 468)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.317 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.319 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">[2023-10-18 05:46:40.319] End Compile ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.319 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.319 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">(Filename:  Line: 500)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.319 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.320 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">[2023-10-18 05:46:40.320] Begin Compile ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.320 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.320 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">(Filename:  Line: 468)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.320 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.321 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">[2023-10-18 05:46:40.321] End Compile ComputeShader:BuildHIZ.HZBBuildCS
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.321 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.321 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">(Filename:  Line: 500)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:40.321 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.508 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:43.508] Genshin Start Log: GameManager Awake - NowTimeStamp:1697579203
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.550 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:43.549] Genshin Start Log: GameManager Start - NowTimeStamp:1697579203
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.550 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:43.550] Genshin Start Log: GameManager InitGame - NowTimeStamp:1697579203
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.565 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:43.565] Load DownloadPref: {"resStatus":[0,0],"redownloadUselessAudio":false,"redownloadUselessVideo":false}
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.565 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">DJMNDPNJCKD:OMMJEAGFEBP()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.565 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.GameManager:HOOLDBCLMMF()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.565 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.565 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">(Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.565 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.578 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:43.578] IsBaseResVersionHashChanged=> baseResVersionHashInPersist = b8ad419157e6112db0fc9fb117ef4a9f, md5 in streamingResVersion = b8ad419157e6112db0fc9fb117ef4a9f
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.578 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.GameManager:HOOLDBCLMMF()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.578 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.578 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">(Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:43.578 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:44.791 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:44.791] [MTRManager]client create sucess!
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:44.791 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.GameManager:AEHPIEMNCIN()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:44.791 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.GameManager:HOOLDBCLMMF()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:44.791 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:44.791 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">(Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:44.791 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:44.826 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:44.826] Genshin Start Log: GameManager ShowLogo - NowTimeStamp:1697579204
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:44.888 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:44.888] Genshin Start Log: LogoPageContext SetupView - NowTimeStamp:1697579204
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.884 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:47.884] Genshin Start Log: LogoPageContext ClosePage - NowTimeStamp:1697579207
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.884 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:47.884] Genshin Start Log: GameManager StartHome - NowTimeStamp:1697579207
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.916 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:47.916] Genshin Start Log: GameManager ChangeGameWorld Home - NowTimeStamp:1697579207
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.924 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:47.924] Genshin Start Log: GameManager CreateNewGameWorld Home - NowTimeStamp:1697579207
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.939 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:47.939] Genshin Start Log: Home LoadScene - NowTimeStamp:1697579207
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:47.961] Texture streaming preload close!
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">OLHIFOGGMIM:MoveNext()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.MonoBehaviour:StartCoroutine(IEnumerator)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">JBLGLCLGBKE:CIIBFDCPMNB(IEnumerator, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">AEJMFLHFEPL:ILMJEICJEOM()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.GameManager:KPHEGEBOONL(WorldType, UInt32, String, String)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.EEGFAFEFKOC:LLDKNDHIIIH()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">JFONKPLEEGN:Invoke()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">HKELOMNMLFL:Tick()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.GameManager:ONCKPFPBFNI()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.GameManager:Update()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[ line 273] 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">(Filename:  Line: 273)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.961 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:47.961] Genshin Start Log: GameManager FirstChangeToHomeCallback - NowTimeStamp:1697579207
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:47.966] Texture streaming preload close!
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">KAEEPNKKCDK:JKANBEOJLHH()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.GameManager:ABJOLHANEPM()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">System.Action:Invoke()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.EEGFAFEFKOC:LLDKNDHIIIH()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">JFONKPLEEGN:Invoke()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">HKELOMNMLFL:Tick()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.GameManager:ONCKPFPBFNI()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.GameManager:Update()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[ line 273] 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">(Filename:  Line: 273)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:47.966 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:48.393 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:48.393] Genshin Start Log: LoginMainPageContext SetupView - NowTimeStamp:1697579208
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:49.333] On Mobile Platform, FSR quality is fixed on FLOAT16MOBILE
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.Rendering.PostProcessing.PostProcessLayer:OnEnable()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.Object:Internal_CloneSingle(Object)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.Object:Instantiate(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.StatExtension:Instantiate(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.MonoLoginScene:Awake()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.Object:Instantiate(Object, Transform, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.Object:Instantiate(T, Transform)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.StatExtension:Instantiate(T, Transform)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">NKMBPJJPGEF:NLBBIPMBEAH()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">NKMBPJJPGEF:SetupView()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.BaseContext:Setup()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">HLFIMACGGAA:OnLoadedView(GameObject)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">System.Action`1:Invoke(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">System.Action`1:Invoke(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG, GameObject, Action`1)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">GPMBIMCJPFC:LCDDBGAEMHI(BaseContext, Action`1, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">HLFIMACGGAA:Init()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">GPMBIMCJPFC:AONNCDKCNFG(WorldType, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">OLHIFOGGMIM:MoveNext()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.333 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">(Filena
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">[2023-10-18 05:46:49.337] Checkboard Setting: None
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">MoleMole.MonoLoginScene:Awake()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">UnityEngine.Object:Instantiate(Object, Transform, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">UnityEngine.Object:Instantiate(T, Transform)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">MoleMole.StatExtension:Instantiate(T, Transform)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">NKMBPJJPGEF:NLBBIPMBEAH()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">NKMBPJJPGEF:SetupView()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">MoleMole.BaseContext:Setup()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">HLFIMACGGAA:OnLoadedView(GameObject)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">System.Action`1:Invoke(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">System.Action`1:Invoke(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG, GameObject, Action`1)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">GPMBIMCJPFC:LCDDBGAEMHI(BaseContext, Action`1, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">HLFIMACGGAA:Init()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">GPMBIMCJPFC:AONNCDKCNFG(WorldType, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">OLHIFOGGMIM:MoveNext()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">(Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.337 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:49.339] On Mobile Platform, FSR quality is fixed on FLOAT16MOBILE
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MEGHBLMAFHN:GMNJPNCOKJF(Camera, Boolean, HHBHHDMINPG, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.MonoLoginScene:DGGPJOJAOCN(Camera)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.MonoLoginScene:Awake()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.Object:Instantiate(Object, Transform, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.Object:Instantiate(T, Transform)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.StatExtension:Instantiate(T, Transform)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">NKMBPJJPGEF:NLBBIPMBEAH()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">NKMBPJJPGEF:SetupView()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.BaseContext:Setup()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">HLFIMACGGAA:OnLoadedView(GameObject)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">System.Action`1:Invoke(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">System.Action`1:Invoke(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG, GameObject, Action`1)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">GPMBIMCJPFC:LCDDBGAEMHI(BaseContext, Action`1, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">HLFIMACGGAA:Init()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">GPMBIMCJPFC:AONNCDKCNFG(WorldType, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">OLHIFOGGMIM:MoveNext()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.339 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">(Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindin
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:49.344] Texture streaming preload close!
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.MonoLoginScene:Awake()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.Object:Instantiate(Object, Transform, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.Object:Instantiate(T, Transform)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.StatExtension:Instantiate(T, Transform)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">NKMBPJJPGEF:NLBBIPMBEAH()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">NKMBPJJPGEF:SetupView()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">MoleMole.BaseContext:Setup()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">HLFIMACGGAA:OnLoadedView(GameObject)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">System.Action`1:Invoke(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">System.Action`1:Invoke(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG, GameObject, Action`1)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">GPMBIMCJPFC:LCDDBGAEMHI(BaseContext, Action`1, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">HLFIMACGGAA:Init()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">GPMBIMCJPFC:AONNCDKCNFG(WorldType, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">OLHIFOGGMIM:MoveNext()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[ line 273] 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">(Filename:  Line: 273)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.344 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">[2023-10-18 05:46:49.346] Checkboard Setting: None
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">MoleMole.MonoLoginScene:Awake()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">UnityEngine.Object:Instantiate(Object, Transform, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">UnityEngine.Object:Instantiate(T, Transform)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">MoleMole.StatExtension:Instantiate(T, Transform)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">NKMBPJJPGEF:NLBBIPMBEAH()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">NKMBPJJPGEF:SetupView()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">MoleMole.BaseContext:Setup()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">HLFIMACGGAA:OnLoadedView(GameObject)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">System.Action`1:Invoke(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">System.Action`1:Invoke(T)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">JFNKFMBKNBE:HLNJKMGFMFM(MKNNHKMPCOG, GameObject, Action`1)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">JFNKFMBKNBE:OPKLNDPCFBJ(MKNNHKMPCOG, Action`1, Boolean, BaseContext)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">GPMBIMCJPFC:LCDDBGAEMHI(BaseContext, Action`1, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">HLFIMACGGAA:Init()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">GPMBIMCJPFC:JMLINLCCOFM(HLFIMACGGAA, Boolean, LEHAGMFMNLH)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">GPMBIMCJPFC:AONNCDKCNFG(WorldType, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">OLHIFOGGMIM:MoveNext()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-yellow">(Filename: E:/WKSPC/4.1Fix/sourceCode/artifacts/generated/Android/runtime/DebugBindings.gen.cpp Line: 64)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.346 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-yellow">
            <span class="terminal-white"> W 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.458 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:49.458] Genshin Start Log: LoginMainPageContext OnAgreement - NowTimeStamp:1697579209
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:49.514 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:49.514] Genshin Start Log: LoginMainPageContext OnPreInit - NowTimeStamp:1697579209
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.176 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:50.176] Genshin Start Log: LoginMainPageContext InitServerDispatch - NowTimeStamp:1697579210
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.176 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:50.176] Genshin Start Log: NetworkManager ConnectGlobalDispatchServer 1 - NowTimeStamp:1697579210
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.176 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:50.176] Genshin Start Log: NetworkManager ConnectGlobalDispatchServer https://dispatchosglobal.yuanshen.com/query_region_list - NowTimeStamp:1697579210
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.576 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:50.576] Genshin Start Log: NetworkManager OnConnectGlobalDispatch - NowTimeStamp:1697579210
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.578 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:50.578] Genshin Start Log: NetworkManager SetServerDispatchConfig isGlobal=True - NowTimeStamp:1697579210
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.581 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:50.581] Set preload tick time scale to 1.000000
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.581 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">CKOJLGMPICC:PAADLIHJLNL(JSONNode, Boolean)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.581 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">LJINHHECAKE:NFJCJNGPJAC(Byte[], Byte[], CALMLBFFIMH)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.581 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">LJINHHECAKE:BIFMNBAPKOL(String, Action)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.581 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">LBPBMNIPEDJ:MoveNext()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.581 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.581 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.581 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[ line 68] 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.581 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">(Filename:  Line: 68)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.581 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.582 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:50.582] Wrote 0 persistent code switches
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.582 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">LJINHHECAKE:BIFMNBAPKOL(String, Action)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.582 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">LBPBMNIPEDJ:MoveNext()
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.582 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">UnityEngine.SetupCoroutine:InvokeMoveNext(IEnumerator, IntPtr)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.582 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.582 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[ line 210] 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.582 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">(Filename:  Line: 210)
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.582 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.593 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:50.593] Genshin Start Log: LoginMainPageContext OnGlobalDP - NowTimeStamp:1697579210
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.621 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:50.621] Genshin Start Log: LoginMainPageContext OnLogin - NowTimeStamp:1697579210
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:50.622 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:50.622] Genshin Start Log: MiHoYoSDKManager SDKInit - NowTimeStamp:1697579210
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:51.064 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:51.064] Genshin Start Log: LoginMainPageContext OnInitResponse - NowTimeStamp:1697579211
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-purple"> 10-18 00:46:51.064 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <b>
          <span class="terminal-bg-green">
            <span class="terminal-white"> I 
            </span>
          </span>
        </b>
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-cyan">[23548/23614]
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> Unity   
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white"> 
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-green">[2023-10-18 05:46:51.064] Genshin Start Log: MiHoYoSDKManager SDKLogin - NowTimeStamp:1697579211
      </span>
    </span>
    <span class="terminal-bg-black">
      <span class="terminal-white">
        <br/>
      </span>
    </span>
  </div>
</details>

## Как получилось всё это нарисовать тут

Чтобы отрисовать ANSI коды (так кодируются цвета — `\e[0;31m`) из терминала на HTML-странице, пришлось прибегнуть к кое-каким ухищрениям:

1. Ставлю `ansi-to-html`:

   ```bash
   sudo npm install -g ansi-to-html
   ```

2. Пишу лог в файл:

   ```bash
   adb logcat -s Unity > session.log
   ```

3. Перекрашиваю лог и, сразу же, конвертирую в HTML, и пишу в файл:

   ```bash
   cat session.log \
   | logcat-colorize \
   | ansi-to-html -n \
   > session.html
   ```

4. Заменяю сгенерированные стили `style="color:#AAA"` на кастомные классы `class="terminal-white"`, чтобы потом подкрасить классы через CSS, по цвету блога.
5. Копирую готовый HTML код в блог.
6. Прописываю стили в CSS, чтобы всё было красиво и единообразно с блогом.

<img src="{{ site.baseurl }}/assets/images/stonks-frontend.png"
     height="360px"
     alt="frontent" />
