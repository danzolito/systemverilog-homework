//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module parallel_to_serial
# (
    parameter width = 8
)
(
    input                      clk,
    input                      rst,

    input                      parallel_valid,
    input        [width - 1:0] parallel_data,

    output                     busy,
    output logic               serial_valid,
    output logic               serial_data
);
    // Task:
    // Implement a module that converts multi-bit parallel value to the single-bit serial data.
    //
    // The module should accept 'width' bit input parallel data when 'parallel_valid' input is asserted.
    // At the same clock cycle as 'parallel_valid' is asserted, the module should output
    // the least significant bit of the input data. In the following clock cycles the module
    // should output all the remaining bits of the parallel_data.
    // Together with providing correct 'serial_data' value, module should also assert the 'serial_valid' output.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.

    logic [width-1:0] data_reg;
    logic [$clog2(width)-1:0]    bit_idx;
    logic             busy_reg;

    assign busy         = busy_reg | parallel_valid;
    assign serial_valid = busy_reg | parallel_valid;
    assign serial_data  = parallel_valid ? parallel_data[0] : data_reg[bit_idx];

    always_ff @(posedge clk)
        if (rst)
        begin
            data_reg <= '0;
            bit_idx  <= '0;
            busy_reg <= 1'b0;
        end
        else if (parallel_valid)
        begin
            data_reg <= parallel_data;
            bit_idx  <= 1;
            busy_reg <= 1'b1;
        end
        else if (busy_reg)
        begin
            if (bit_idx == width - 1)
            begin
                bit_idx  <= '0;
                busy_reg <= 1'b0;
            end
            else
                bit_idx <= bit_idx + 1;
        end


endmodule
