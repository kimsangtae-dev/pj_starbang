package project.star.b2.model;

public class Gu {
    private String guName;
    private double guLat;
    private double guLng;
    private int guCount;

    public Gu(String guName, double guLat, double guLng, int guCount) {
        super();
        this.guName = guName;
        this.guLat = guLat;
        this.guLng = guLng;
        this.guCount = guCount;
    }

    public String getGuName() {
        return guName;
    }

    public void setGuName(String guName) {
        this.guName = guName;
    }

    public double getGuLat() {
        return guLat;
    }

    public void setGuLat(double guLat) {
        this.guLat = guLat;
    }

    public double getGuLng() {
        return guLng;
    }

    public void setGuLng(double guLng) {
        this.guLng = guLng;
    }

    public int getGuCount() {
        return guCount;
    }

    public void setGuCount(int guCount) {
        this.guCount = guCount;
    }

}
