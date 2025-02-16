const std = @import("std");

pub const vec3 = struct {
    // e: [3]f64,
    e: [3]f64 = .{ 0, 0, 0 },

    pub fn init(e0: f64, e1: f64, e2: f64) @This() {
        return @This(){ .e = .{ e0, e1, e2 } };
    }

    pub fn x(self: @This()) f64 {
        return self.e[0];
    }

    pub fn y(self: @This()) f64 {
        return self.e[1];
    }

    pub fn z(self: @This()) f64 {
        return self.e[2];
    }

    pub fn negate(self: @This()) @This() {
        return @This(){ .e = .{ -self.e[0], -self.e[1], -self.e[2] } };
    }

    pub fn addAssign(self: *@This(), v: @This()) *@This() {
        self.e[0] += v.e[0];
        self.e[1] += v.e[1];
        self.e[2] += v.e[2];
        return self;
    }

    pub fn mulAssign(self: *@This(), t: f64) *@This() {
        self.e[0] *= t;
        self.e[1] *= t;
        self.e[2] *= t;
        return self;
    }

    pub fn divAssign(self: *@This(), t: f64) *@This() {
        return self.mulAssign(1.0 / t);
    }

    pub fn length(self: *const @This()) f64 {
        return @sqrt(self.length_squared());
    }

    pub fn length_squared(self: *const @This()) f64 {
        return self.e[0] * self.e[0] + self.e[1] * self.e[1] + self.e[2] * self.e[2];
    }

    // helper utilities

    // Zig formatting interface implementation
    pub fn format(
        self: @This(),
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = fmt; // Unused parameters
        _ = options; // (silence compiler warnings)
        try writer.print("{d} {d} {d}", .{ self.e[0], self.e[1], self.e[2] });
    }

    // Vector operations
    pub fn add(a: @This(), b: @This()) @This() {
        return .{
            .e = .{
                a.e[0] + b.e[0],
                a.e[1] + b.e[1],
                a.e[2] + b.e[2],
            },
        };
    }

    pub fn sub(a: @This(), b: @This()) @This() {
        return .{
            .e = .{
                a.e[0] - b.e[0],
                a.e[1] - b.e[1],
                a.e[2] - b.e[2],
            },
        };
    }

    pub fn mul(a: @This(), b: @This()) @This() {
        return .{
            .e = .{
                a.e[0] * b.e[0],
                a.e[1] * b.e[1],
                a.e[2] * b.e[2],
            },
        };
    }

    pub fn scale(v: @This(), t: f64) @This() {
        return .{
            .e = .{
                v.e[0] * t,
                v.e[1] * t,
                v.e[2] * t,
            },
        };
    }

    pub fn divScalar(v: @This(), t: f64) @This() {
        return scale(v, 1 / t);
    }

    pub fn dot(a: @This(), b: @This()) f64 {
        return a.e[0] * b.e[0] + a.e[1] * b.e[1] + a.e[2] * b.e[2];
    }

    pub fn cross(a: @This(), b: @This()) @This() {
        return .{
            .e = .{
                a.e[1] * b.e[2] - a.e[2] * b.e[1],
                a.e[2] * b.e[0] - a.e[0] * b.e[2],
                a.e[0] * b.e[1] - a.e[1] * b.e[0],
            },
        };
    }

    pub fn unit(v: @This()) @This() {
        return divScalar(v, v.length());
    }
};

pub const point3: vec3 = vec3;
