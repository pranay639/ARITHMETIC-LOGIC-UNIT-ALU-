module ALU (
    input [7:0] A,        // First Operand
    input [7:0] B,        // Second Operand
    input [2:0] ALU_Control, // Control signal to select operation
    output reg [7:0] ALU_Result, // ALU Result
    output reg Zero       // Zero flag (for equality check)
);

    // ALU Operation Codes
    parameter ADD = 3'b000; // Addition
    parameter SUB = 3'b001; // Subtraction
    parameter AND_OP = 3'b010; // AND
    parameter OR_OP = 3'b011; // OR
    parameter NOT_OP = 3'b100; // NOT

    always @ (A, B, ALU_Control) begin
        case (ALU_Control)
            ADD: ALU_Result = A + B; // Addition
            SUB: ALU_Result = A - B; // Subtraction
            AND_OP: ALU_Result = A & B; // AND operation
            OR_OP: ALU_Result = A | B; // OR operation
            NOT_OP: ALU_Result = ~A; // NOT operation (Only applies to A)
            default: ALU_Result = 8'b00000000; // Default to zero for invalid operation
        endcase

        // Set Zero flag (1 if result is zero)
        if (ALU_Result == 8'b00000000)
            Zero = 1;
        else
            Zero = 0;
    end
endmodule
Testbench (Verilog Code)
module ALU_tb;

    // Testbench signals
    reg [7:0] A, B;
    reg [2:0] ALU_Control;
    wire [7:0] ALU_Result;
    wire Zero;

    // Instantiate the ALU
    ALU alu_inst (
        .A(A),
        .B(B),
        .ALU_Control(ALU_Control),
        .ALU_Result(ALU_Result),
        .Zero(Zero)
    );

    initial begin
        // Test Case 1: Addition
        A = 8'b00001010; // A = 10
        B = 8'b00000101; // B = 5
        ALU_Control = 3'b000; // ADD operation
        #10; // Wait for 10 time units
        $display("ADD: A = %d, B = %d, Result = %d, Zero = %b", A, B, ALU_Result, Zero);

        // Test Case 2: Subtraction
        A = 8'b00001010; // A = 10
        B = 8'b00000101; // B = 5
        ALU_Control = 3'b001; // SUB operation
        #10;
        $display("SUB: A = %d, B = %d, Result = %d, Zero = %b", A, B, ALU_Result, Zero);

        // Test Case 3: AND operation
        A = 8'b00001101; // A = 13
        B = 8'b00000111; // B = 7
        ALU_Control = 3'b010; // AND operation
        #10;
        $display("AND: A = %b, B = %b, Result = %b, Zero = %b", A, B, ALU_Result, Zero);

        // Test Case 4: OR operation
        A = 8'b00001101; // A = 13
        B = 8'b00000111; // B = 7
        ALU_Control = 3'b011; // OR operation
        #10;
        $display("OR: A = %b, B = %b, Result = %b, Zero = %b", A, B, ALU_Result, Zero);

        // Test Case 5: NOT operation
        A = 8'b00001010; // A = 10
        B = 8'b00000000; // B = 0 (B is ignored in NOT operation)
        ALU_Control = 3'b100; // NOT operation
        #10;
        $display("NOT: A = %b, Result = %b, Zero = %b", A, ALU_Result, Zero);
        
        $finish;
    end

endmodule


      

