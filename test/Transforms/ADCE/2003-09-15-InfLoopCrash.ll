; RUN: opt < %s -passes=adce -disable-output
; RUN: opt < %s -passes=adce -adce-remove-loops -disable-output

define i32 @main() {
        br label %loop

loop:           ; preds = %loop, %0
        br label %loop
}

