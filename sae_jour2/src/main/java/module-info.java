module sae2025 {
    requires javafx.graphics;
    requires javafx.fxml;
    requires javafx.controls;
    requires java.net.http;
    requires java.desktop;
	requires org.junit.jupiter.api;

    opens app.model.map;

    opens app to javafx.fxml;
    exports app;
}