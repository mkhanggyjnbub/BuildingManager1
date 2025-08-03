import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class TestSelenium {
    public static void main(String[] args) {
        // BƯỚC 1: Trỏ đến chromedriver.exe
        System.setProperty("webdriver.chrome.driver", "C:/Users/prokh/OneDrive/Desktop/chromedriver-win64/chromedriver.exe"); // sửa đường dẫn nếu khác

        // BƯỚC 2: Khởi tạo trình duyệt
        WebDriver driver = new ChromeDriver();  

        try {
            // BƯỚC 3: Mở trang web
            driver.get("https://www.google.com");

            // BƯỚC 4: Tìm ô tìm kiếm và nhập từ khóa
            WebElement searchBox = driver.findElement(By.name("q"));
            searchBox.sendKeys("Selenium WebDriver");
            searchBox.submit();

            // BƯỚC 5: Đợi vài giây để xem kết quả
            Thread.sleep(3000);

            // BƯỚC 6: In tiêu đề trang kết quả ra console
            System.out.println("Tiêu đề trang: " + driver.getTitle());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // BƯỚC 7: Đóng trình duyệt
            driver.quit();
        }
    }
}
