module Detection(
    input clk,            // إشارة الساعة
    input reset,          // إشارة إعادة التهيئة
    input entry_M18,      // إشارة دخول (غير مستقرة)
    input exit_P17,       // إشارة خروج (غير مستقرة)
    output entry_pulse,   // نبضة عند الحافة الصاعدة لإشارة الدخول
    output exit_pulse     // نبضة عند الحافة الصاعدة لإشارة الخروج
);
    reg entry_M18_prev, exit_P17_prev;

    // منطق الكشف عن الحواف
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            entry_M18_prev <= 0;
            exit_P17_prev <= 0;
        end else begin
            entry_M18_prev <= entry_M18;
            exit_P17_prev <= exit_P17;
        end
    end

    // إنشاء النبضات
    assign entry_pulse = entry_M18 && !entry_M18_prev; // كشف الحافة الصاعدة لإشارة الدخول
    assign exit_pulse = exit_P17 && !exit_P17_prev;    // كشف الحافة الصاعدة لإشارة الخروج
endmodule
