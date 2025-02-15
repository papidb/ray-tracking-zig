const std = @import("std");

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    const image_width = 256;
    const image_height = 256;

    try stdout.print("P3\n", .{});
    try stdout.print("{d} {d}\n", .{ image_width, image_height });
    try stdout.print("255\n", .{});

    const delta = 255.999;

    var j: u32 = 0;
    while (j < image_height) : (j += 1) {
        var i: u32 = 0; // Reset i for each row
        std.debug.print("\rScan lines Remaining: {d} ", .{(image_height - j)});
        while (i < image_width) : (i += 1) {
            const r: f32 = @as(f32, @floatFromInt(i)) / @as(f32, @floatFromInt(image_width - 1));
            const g: f32 = @as(f32, @floatFromInt(j)) / @as(f32, @floatFromInt(image_height - 1));
            const b: f32 = 0.0;

            const ir: u32 = @intFromFloat(delta * r);
            const ig: u32 = @intFromFloat(delta * g);
            const ib: u32 = @intFromFloat(delta * b);

            try stdout.print("{d} {d} {d}\n", .{ ir, ig, ib });
        }
    }

    std.debug.print("\rDone     \n", .{});
    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
