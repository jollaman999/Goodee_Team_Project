package exception;

public class LogInException extends RuntimeException {
    private String url;

    public LogInException(String msg, String url) {
        super(msg);
        this.url = url;
    }

    public String getUrl() {
        return url;
    }
}
