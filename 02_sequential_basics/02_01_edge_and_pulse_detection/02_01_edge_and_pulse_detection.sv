//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module posedge_detector (input clk, rst, a, output detected);

  logic a_r;

  // Note:
  // The a_r flip-flop input value d propogates to the output q
  // only on the next clock cycle.

  always_ff @ (posedge clk)
    if (rst)
      a_r <= '0;
    else
      a_r <= a;

  assign detected = ~ a_r & a;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module one_cycle_pulse_detector (input clk, rst, a, output detected);

  // Task:
  // Create an one cycle pulse (010) detector.
  //
  // Note:
  // See the testbench for the output format ($display task).

  // localparam logic [2:0] KEY = 3'b010;

  // logic [2:0] strob = 3'b000;

  // always_ff @ (posedge clk)
  //   if (rst)
  //     strob <= 3'b000;
  //   else
  //     strob <= {strob[1:0], a};

  // assign detected = ({strob[1:0], a} == KEY);

  // logic r1 = '0;
  // logic r2 = '0;

  // always_ff @ (posedge clk)
  //   if (rst)
  //     begin
  //       r1 <= '0;
  //       r2 <= '0;
  //     end
  //   else
  //     begin
  //       r1 <= a;
  //       r2 <= r1;
  //     end
    
  //   assign detected = ~ r2 & r1 & ~ a;

  // logic r1 = '0;
  // logic r2 = '0;

  // always_ff @ (posedge clk)
  //   if (rst)
  //     {r1, r2} <= 2'b00;
  //   else
  //   {r1, r2} <= {a, r1};
    
  //   assign detected = ~ r2 & r1 & ~ a;

  logic [1:0] a_r;

  always_ff @(posedge clk)
    if (rst)
      a_r <= '0;
    else
      a_r <= {a_r[0], a};

  assign detected = ({a_r, a} == 3'b010);
  
endmodule
