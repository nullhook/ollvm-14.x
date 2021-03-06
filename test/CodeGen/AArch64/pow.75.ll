; RUN: llc < %s -mtriple=aarch64-- -debug 2>&1 | FileCheck %s
; REQUIRES: asserts

declare float @llvm.pow.f32(float, float)
declare <4 x float> @llvm.pow.v4f32(<4 x float>, <4 x float>)
declare double @llvm.pow.f64(double, double)
declare <2 x double> @llvm.pow.v2f64(<2 x double>, <2 x double>)

define float @pow_f32_three_fourth_fmf(float %x) nounwind {
; CHECK: Combining: {{.*}}: f32 = fpow ninf nsz afn [[X:t[0-9]+]], ConstantFP:f32<7.500000e-01>
; CHECK-NEXT: Creating new node: [[SQRT:t[0-9]+]]: f32 = fsqrt ninf nsz afn [[X]]
; CHECK-NEXT: Creating new node: [[SQRTSQRT:t[0-9]+]]: f32 = fsqrt ninf nsz afn [[SQRT]]
; CHECK-NEXT: Creating new node: [[R:t[0-9]+]]: f32 = fmul ninf nsz afn [[SQRT]], [[SQRTSQRT]]
; CHECK-NEXT:  ... into: [[R]]: f32 = fmul ninf nsz afn [[SQRT]], [[SQRTSQRT]]
  %r = call nsz ninf afn float @llvm.pow.f32(float %x, float 7.5e-01)
  ret float %r
}

define double @pow_f64_three_fourth_fmf(double %x) nounwind {
; CHECK: Combining: {{.*}}: f64 = fpow ninf nsz afn [[X:t[0-9]+]], ConstantFP:f64<7.500000e-01>
; CHECK-NEXT: Creating new node: [[SQRT:t[0-9]+]]: f64 = fsqrt ninf nsz afn [[X]]
; CHECK-NEXT: Creating new node: [[SQRTSQRT:t[0-9]+]]: f64 = fsqrt ninf nsz afn [[SQRT]]
; CHECK-NEXT: Creating new node: [[R:t[0-9]+]]: f64 = fmul ninf nsz afn [[SQRT]], [[SQRTSQRT]]
; CHECK-NEXT:  ... into: [[R]]: f64 = fmul ninf nsz afn [[SQRT]], [[SQRTSQRT]]
  %r = call nsz ninf afn double @llvm.pow.f64(double %x, double 7.5e-01)
  ret double %r
}

define <4 x float> @pow_v4f32_three_fourth_fmf(<4 x float> %x) nounwind {
; CHECK: Combining: {{.*}}: v4f32 = fpow nnan ninf nsz arcp contract afn reassoc [[X:t[0-9]+]], {{.*}}
; CHECK-NEXT: Creating new node: [[SQRT:t[0-9]+]]: v4f32 = fsqrt nnan ninf nsz arcp contract afn reassoc [[X]]
; CHECK-NEXT: Creating new node: [[SQRTSQRT:t[0-9]+]]: v4f32 = fsqrt nnan ninf nsz arcp contract afn reassoc [[SQRT]]
; CHECK-NEXT: Creating new node: [[R:t[0-9]+]]: v4f32 = fmul nnan ninf nsz arcp contract afn reassoc [[SQRT]], [[SQRTSQRT]]
; CHECK-NEXT:  ... into: [[R]]: v4f32 = fmul nnan ninf nsz arcp contract afn reassoc [[SQRT]], [[SQRTSQRT]]
  %r = call fast <4 x float> @llvm.pow.v4f32(<4 x float> %x, <4 x float> <float 7.5e-1, float 7.5e-1, float 7.5e-01, float 7.5e-01>)
  ret <4 x float> %r
}

define <2 x double> @pow_v2f64_three_fourth_fmf(<2 x double> %x) nounwind {
; CHECK: Combining: {{.*}}: v2f64 = fpow nnan ninf nsz arcp contract afn reassoc [[X:t[0-9]+]], {{.*}}
; CHECK-NEXT: Creating new node: [[SQRT:t[0-9]+]]: v2f64 = fsqrt nnan ninf nsz arcp contract afn reassoc [[X]]
; CHECK-NEXT: Creating new node: [[SQRTSQRT:t[0-9]+]]: v2f64 = fsqrt nnan ninf nsz arcp contract afn reassoc [[SQRT]]
; CHECK-NEXT: Creating new node: [[R:t[0-9]+]]: v2f64 = fmul nnan ninf nsz arcp contract afn reassoc [[SQRT]], [[SQRTSQRT]]
; CHECK-NEXT:  ... into: [[R]]: v2f64 = fmul nnan ninf nsz arcp contract afn reassoc [[SQRT]], [[SQRTSQRT]]
  %r = call fast <2 x double> @llvm.pow.v2f64(<2 x double> %x, <2 x double> <double 7.5e-1, double 7.5e-1>)
  ret <2 x double> %r
}
