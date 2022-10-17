`timescale 1ns / 1ps

module Top_LightStand(
    input i_clk,
    input i_reset,
    input [2:0] i_button,

    output o_light
    );

    wire w_clk;

    ClockDivider clkdiv(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_clk(w_clk)
    );

    wire [9:0] w_counter;

    Counter cnt(
        .i_clk(w_clk),
        .i_reset(i_reset),
        .o_counter(w_counter)
    );

    wire [3:0] w_light;

    Comparator cpm(
        .i_counter(w_counter),
        .o_light_1(w_light[0]),
        .o_light_2(w_light[1]),
        .o_light_3(w_light[2]),
        .o_light_4(w_light[3])
    );

    wire [2:0] w_button;
    
    ButtonController btn0(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button[0]),
        .o_button(w_button[0])
    );

    ButtonController btn1(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button[1]),
        .o_button(w_button[1])
    );

    ButtonController btn2(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button[2]),
        .o_button(w_button[2])
    );

    wire [2:0] w_lightState;

    FSM_LightState FSM(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(w_button),
        .o_lightState(w_lightState)
    );

    Mux_5x1 mux(
        .i_x(w_light),
        .i_sel(w_lightState),
        .o_y(o_light)
    );
endmodule
