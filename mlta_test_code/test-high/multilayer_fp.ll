; ModuleID = 'multilayer_fp.bc'
source_filename = "multilayer_fp.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Operations = type { ptr, ptr }

@.str = private unnamed_addr constant [24 x i8] c"Addition: %d + %d = %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [27 x i8] c"Subtraction: %d - %d = %d\0A\00", align 1
@.str.2 = private unnamed_addr constant [30 x i8] c"Multiplication: %d * %d = %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [24 x i8] c"Division: %d / %d = %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [24 x i8] c"Division by zero error\0A\00", align 1
@__const.main.ops = private unnamed_addr constant %struct.Operations { ptr @add, ptr @subtract }, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @add(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = load i32, ptr %4, align 4
  %9 = add nsw i32 %7, %8
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %5, i32 noundef %6, i32 noundef %9)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @subtract(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = load i32, ptr %4, align 4
  %9 = sub nsw i32 %7, %8
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %5, i32 noundef %6, i32 noundef %9)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @multiply(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = load i32, ptr %4, align 4
  %9 = mul nsw i32 %7, %8
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %5, i32 noundef %6, i32 noundef %9)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @divide(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %14

7:                                                ; preds = %2
  %8 = load i32, ptr %3, align 4
  %9 = load i32, ptr %4, align 4
  %10 = load i32, ptr %3, align 4
  %11 = load i32, ptr %4, align 4
  %12 = sdiv i32 %10, %11
  %13 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %8, i32 noundef %9, i32 noundef %12)
  br label %16

14:                                               ; preds = %2
  %15 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  br label %16

16:                                               ; preds = %14, %7
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Operations, align 8
  store i32 0, ptr %1, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %2, ptr align 8 @__const.main.ops, i64 16, i1 false)
  %3 = getelementptr inbounds %struct.Operations, ptr %2, i32 0, i32 0
  %4 = load ptr, ptr %3, align 8
  call void %4(i32 noundef 10, i32 noundef 5)
  %5 = getelementptr inbounds %struct.Operations, ptr %2, i32 0, i32 1
  %6 = load ptr, ptr %5, align 8
  call void %6(i32 noundef 10, i32 noundef 5)
  %7 = getelementptr inbounds %struct.Operations, ptr %2, i32 0, i32 0
  store ptr @multiply, ptr %7, align 8
  %8 = getelementptr inbounds %struct.Operations, ptr %2, i32 0, i32 1
  store ptr @divide, ptr %8, align 8
  %9 = getelementptr inbounds %struct.Operations, ptr %2, i32 0, i32 0
  %10 = load ptr, ptr %9, align 8
  call void %10(i32 noundef 10, i32 noundef 5)
  %11 = getelementptr inbounds %struct.Operations, ptr %2, i32 0, i32 1
  %12 = load ptr, ptr %11, align 8
  call void %12(i32 noundef 10, i32 noundef 0)
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
