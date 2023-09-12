const std = @import("std");
const prng = std.rand.DefaultPrng;
const time = std.time;

const Uuid = @import("uuid").UUID;

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    var args = try std.process.argsWithAllocator(allocator);
    defer args.deinit();

    const prog = args.next().?;
    const format = args.next() orelse {
        std.log.err("usage: {s} (number|uuidv4)", .{prog});

        return error.InvalidArgument;
    };

    const stdout = std.io.getStdOut();
    const writer = stdout.writer();
    var rand = prng.init(@intCast(time.milliTimestamp()));

    if (std.mem.eql(u8, format, "number")) {
        try writer.print("{}\n", .{rand.random().int(u32)});
    }

    // jdknezek/uuid6-zig
    // if (std.mem.eql(u8, format, "uuidv4")) {
    //     const source = Uuid.v4.Source.init(rand.random());
    //     const uuid = source.create();
    //     try writer.print("{s}\n", .{uuid});
    // }
    //
    // if (std.mem.eql(u8, format, "uuidv6")) {
    //     var clock = Uuid.Clock.init(rand.random());
    //     const source = Uuid.v6.Source.init(&clock, rand.random());
    //     const uuid = source.create();
    //     try writer.print("{s}\n", .{uuid});
    // }

    // dmgk/zig-uuid
    if (std.mem.eql(u8, format, "uuidv4")) {
        const uuid1 = Uuid.init();
        try writer.print("{s}\n", .{uuid1});
    }
}
