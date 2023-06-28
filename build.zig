const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const libSDL_dep = b.dependency("SDL", .{});

    const libSDL = libSDL_dep.artifact("SDL2");

    const lib = b.addStaticLibrary(.{
        .name = "SDL_mixer",
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });

    lib.linkLibC();

    lib.addIncludePath("include");
    lib.addIncludePath("src");
    lib.addIncludePath("src/codecs");

    lib.defineCMacro("MUSIC_FLAC_DRFLAC", "1");
    lib.defineCMacro("MUSIC_MP3_DRMP3", "1");
    lib.defineCMacro("MUSIC_WAV", "1");
    lib.defineCMacro("MUSIC_OGG", "1");
    lib.defineCMacro("OGG_USE_STB", "1");

    lib.linkLibrary(libSDL);

    lib.addCSourceFiles(&.{
        "src/codecs/load_aiff.c",
        "src/codecs/load_voc.c",
        "src/codecs/mp3utils.c",
        "src/codecs/music_cmd.c",
        "src/codecs/music_drflac.c",
        "src/codecs/music_drmp3.c",
        "src/codecs/music_flac.c",
        "src/codecs/music_fluidsynth.c",
        "src/codecs/music_modplug.c",
        "src/codecs/music_mpg123.c",
        "src/codecs/music_nativemidi.c",
        "src/codecs/music_ogg.c",
        "src/codecs/music_ogg_stb.c",
        "src/codecs/music_opus.c",
        "src/codecs/music_timidity.c",
        "src/codecs/music_wav.c",
        "src/codecs/music_xmp.c",
        "src/codecs/native_midi/native_midi_common.c",
        "src/codecs/native_midi/native_midi_macosx.c",
        "src/codecs/native_midi/native_midi_win32.c",
        "src/codecs/timidity/common.c",
        "src/codecs/timidity/instrum.c",
        "src/codecs/timidity/mix.c",
        "src/codecs/timidity/output.c",
        "src/codecs/timidity/playmidi.c",
        "src/codecs/timidity/readmidi.c",
        "src/codecs/timidity/resample.c",
        "src/codecs/timidity/tables.c",
        "src/codecs/timidity/timidity.c",
        "src/effects_internal.c",
        "src/effect_position.c",
        "src/effect_stereoreverse.c",
        "src/mixer.c",
        "src/music.c",
        "src/utils.c"
    }, &.{
        "-std=c99",
    });
    lib.installHeadersDirectory("include", "SDL2");
    b.installArtifact(lib);
}
