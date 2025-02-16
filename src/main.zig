const std = @import("std");
const vec3 = @import("./vec3.zig").vec3;
const color = @import("./color.zig");

pub fn main() !void {
    const width = 256;
    const height = 256;

    const stdout = std.io.getStdOut().writer();

    // PPM header
    try stdout.print("P3\n{} {}\n255\n", .{ width, height });

    // Image data
    for (0..height) |j| {
        for (0..width) |i| {
            const r = @as(f64, @floatFromInt(i)) / (width - 1);
            const g = @as(f64, @floatFromInt(j)) / (height - 1);
            const b = 0;

            try color.writeColor(stdout, color.color.init(r, g, b));
        }
    }
    std.debug.print("\rDone     \n", .{});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
