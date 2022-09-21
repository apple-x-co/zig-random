const std = @import("std");
const prng = std.rand.DefaultPrng;
const time = std.time;

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut();
    const writer = stdout.writer();

    var rand = prng.init(@intCast(u64, time.milliTimestamp()));
    try writer.print("{}\n", .{rand.random().int(u32)});
}