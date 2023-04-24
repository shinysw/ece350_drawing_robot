module preset_controller(clk, reset, presets, square_out, triangle_out, star_out);
    input[2:0] presets;
    output square_out, triangle_out, star_out;

    wire square, square_t, triangle, triangle_t, star, star_t, boof, boof1, boof2;

    assign square = presets[2];
    assign triangle = presets[1];
    assign star = presets[0];

    dffe_ref squaredff(square_t, square, clk, 1'b1, boof);
    dffe_ref triangledff(triangle_t, triangle, clk, 1'b1, boof1);
    dffe_ref stardff(star_t, star, clk, 1'b1, boof2);

    assign square_out = square == 1'b1 && square_t == 1'b0 ? 1'b1 : 1'b0;
    assign triangle_out = triangle == 1'b1 && triangle_t == 1'b0 ? 1'b1 : 1'b0;
    assign star_out = star == 1'b1 && star_t == 1'b0 ? 1'b1 : 1'b0;

endmodule