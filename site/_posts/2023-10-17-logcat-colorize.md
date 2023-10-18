---
layout: post
title:  "logcat: colorize"
---

<span class="hidden">Про раскраску <code>logcat</code></span>

## Контекст

Как-то раз, насмотревшись на вывод logcat в Android Studio (он там цветной, более-менее), мне захотелось раскрашивать его прямо в терминале.

Прямо так сразу, ничего особо лучше этого — не получилось.

Раскрашивалка:

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

Использование:

```bash
logcat -s Unity | ./my-shitty-logcat-colorizer.sh
```

Вывод:

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
