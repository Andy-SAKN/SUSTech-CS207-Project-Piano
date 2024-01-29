import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner duQu = new Scanner(System.in);
        String input = duQu.next();
        input = input.replace("，", ",");
        System.out.println(input);
        String[] fractions = input.split("/");

        StringBuilder resultA = new StringBuilder();
        StringBuilder resultB = new StringBuilder();

        for (int i = fractions.length - 1; i >= 0; i--) {
            String[] parts = fractions[i].split(",");
            int numerator = Integer.parseInt(parts[0]);
            int denominator = Integer.parseInt(parts[1]);

            // 处理 A 的二进制数
            String binaryA = Integer.toBinaryString(numerator);
            resultA.append(String.format("%5s", binaryA).replace(' ', '0'));

            // 处理 B 的二进制数
            String binaryB = Integer.toBinaryString(denominator-1);
            resultB.append(String.format("%2s", binaryB).replace(' ', '0'));

            // 在 A 和 B 之间添加下划线
            if (i > 0) {
                resultA.append("_");
                resultB.append("_");
            }
        }
        System.out.println("Result Note: " + resultA);
        System.out.println("Result Length: " + resultB);
         int length = (resultB.length()+1)/3;
         System.out.println("Length "+ length);


        // 输出结果

    }

}
