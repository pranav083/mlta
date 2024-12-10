; ModuleID = 'multilayer_fp.bc'
source_filename = "multilayer_fp.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Outer = type { %struct.Middle, %struct.Middle }
%struct.Middle = type { %struct.Inner, %struct.Inner }
%struct.Inner = type { %struct.InnerMost, %struct.InnerMost }
%struct.InnerMost = type { ptr }

@.str = private unnamed_addr constant [20 x i8] c"func_x: a=%d, b=%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [20 x i8] c"func_y: a=%d, b=%d\0A\00", align 1
@.str.2 = private unnamed_addr constant [20 x i8] c"func_z: a=%d, b=%d\0A\00", align 1
@.str.3 = private unnamed_addr constant [20 x i8] c"func_w: a=%d, b=%d\0A\00", align 1
@.str.4 = private unnamed_addr constant [20 x i8] c"func_p: a=%d, b=%d\0A\00", align 1
@.str.5 = private unnamed_addr constant [20 x i8] c"func_q: a=%d, b=%d\0A\00", align 1
@.str.6 = private unnamed_addr constant [20 x i8] c"func_r: a=%d, b=%d\0A\00", align 1
@.str.7 = private unnamed_addr constant [20 x i8] c"func_s: a=%d, b=%d\0A\00", align 1
@__const.main.s1 = private unnamed_addr constant %struct.Outer { %struct.Middle { %struct.Inner { %struct.InnerMost { ptr @func_x }, %struct.InnerMost { ptr @func_y } }, %struct.Inner { %struct.InnerMost { ptr @func_z }, %struct.InnerMost { ptr @func_w } } }, %struct.Middle { %struct.Inner { %struct.InnerMost { ptr @func_p }, %struct.InnerMost { ptr @func_q } }, %struct.Inner { %struct.InnerMost { ptr @func_r }, %struct.InnerMost { ptr @func_s } } } }, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @func_x(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %5, i32 noundef %6)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @func_y(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %5, i32 noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @func_z(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %5, i32 noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @func_w(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %5, i32 noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @func_p(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %5, i32 noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @func_q(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %5, i32 noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @func_r(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %5, i32 noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @func_s(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.7, i32 noundef %5, i32 noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Outer, align 8
  store i32 0, ptr %1, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %2, ptr align 8 @__const.main.s1, i64 64, i1 false)
  %3 = getelementptr inbounds %struct.Outer, ptr %2, i32 0, i32 0
  %4 = getelementptr inbounds %struct.Middle, ptr %3, i32 0, i32 0
  %5 = getelementptr inbounds %struct.Inner, ptr %4, i32 0, i32 0
  %6 = getelementptr inbounds %struct.InnerMost, ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %6, align 8
  call void %7(i32 noundef 10, i32 noundef 20)
  %8 = getelementptr inbounds %struct.Outer, ptr %2, i32 0, i32 0
  %9 = getelementptr inbounds %struct.Middle, ptr %8, i32 0, i32 0
  %10 = getelementptr inbounds %struct.Inner, ptr %9, i32 0, i32 1
  %11 = getelementptr inbounds %struct.InnerMost, ptr %10, i32 0, i32 0
  %12 = load ptr, ptr %11, align 8
  call void %12(i32 noundef 30, i32 noundef 40)
  %13 = getelementptr inbounds %struct.Outer, ptr %2, i32 0, i32 0
  %14 = getelementptr inbounds %struct.Middle, ptr %13, i32 0, i32 1
  %15 = getelementptr inbounds %struct.Inner, ptr %14, i32 0, i32 0
  %16 = getelementptr inbounds %struct.InnerMost, ptr %15, i32 0, i32 0
  %17 = load ptr, ptr %16, align 8
  call void %17(i32 noundef 50, i32 noundef 60)
  %18 = getelementptr inbounds %struct.Outer, ptr %2, i32 0, i32 0
  %19 = getelementptr inbounds %struct.Middle, ptr %18, i32 0, i32 1
  %20 = getelementptr inbounds %struct.Inner, ptr %19, i32 0, i32 1
  %21 = getelementptr inbounds %struct.InnerMost, ptr %20, i32 0, i32 0
  %22 = load ptr, ptr %21, align 8
  call void %22(i32 noundef 70, i32 noundef 80)
  %23 = getelementptr inbounds %struct.Outer, ptr %2, i32 0, i32 1
  %24 = getelementptr inbounds %struct.Middle, ptr %23, i32 0, i32 0
  %25 = getelementptr inbounds %struct.Inner, ptr %24, i32 0, i32 0
  %26 = getelementptr inbounds %struct.InnerMost, ptr %25, i32 0, i32 0
  %27 = load ptr, ptr %26, align 8
  call void %27(i32 noundef 15, i32 noundef 25)
  %28 = getelementptr inbounds %struct.Outer, ptr %2, i32 0, i32 1
  %29 = getelementptr inbounds %struct.Middle, ptr %28, i32 0, i32 0
  %30 = getelementptr inbounds %struct.Inner, ptr %29, i32 0, i32 1
  %31 = getelementptr inbounds %struct.InnerMost, ptr %30, i32 0, i32 0
  %32 = load ptr, ptr %31, align 8
  call void %32(i32 noundef 35, i32 noundef 45)
  %33 = getelementptr inbounds %struct.Outer, ptr %2, i32 0, i32 1
  %34 = getelementptr inbounds %struct.Middle, ptr %33, i32 0, i32 1
  %35 = getelementptr inbounds %struct.Inner, ptr %34, i32 0, i32 0
  %36 = getelementptr inbounds %struct.InnerMost, ptr %35, i32 0, i32 0
  %37 = load ptr, ptr %36, align 8
  call void %37(i32 noundef 55, i32 noundef 65)
  %38 = getelementptr inbounds %struct.Outer, ptr %2, i32 0, i32 1
  %39 = getelementptr inbounds %struct.Middle, ptr %38, i32 0, i32 1
  %40 = getelementptr inbounds %struct.Inner, ptr %39, i32 0, i32 1
  %41 = getelementptr inbounds %struct.InnerMost, ptr %40, i32 0, i32 0
  %42 = load ptr, ptr %41, align 8
  call void %42(i32 noundef 75, i32 noundef 85)
  ret i32 0
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { argmemonly nofree nounwind willreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 15.0.0 (git@github.com:llvm/llvm-project.git e758b77161a70d7e7260d8f52bf161a89d73af8a)"}
