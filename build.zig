const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "main",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
        }),
    });

    // add the C source file
    exe.addCSourceFile(.{
        .file = b.path("main.c"),
        .flags = &[_][]const u8{
            "-std=c11",
        },
    });

    // link raylib
    exe.linkSystemLibrary("raylib");
    exe.linkLibC();

    // install the executable
    b.installArtifact(exe);
}
