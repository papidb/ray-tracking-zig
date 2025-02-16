const vec3 = @import("./vec3.zig").vec3;
const std = @import("std");

pub const color = vec3;

pub fn writeColor(
    writer: anytype, // Accept any writer (stdout, files, etc)
    pixel_color: color,
) !void {
    // Clamp values and convert to 0-255 bytes
    const r = pixel_color.x();
    const g = pixel_color.y();
    const b = pixel_color.z();

    const r_byte = @as(u8, @intFromFloat(255.999 * r));
    const g_byte = @as(u8, @intFromFloat(255.999 * g));
    const b_byte = @as(u8, @intFromFloat(255.999 * b));

    try writer.print("{d} {d} {d}\n", .{ r_byte, g_byte, b_byte });
}
