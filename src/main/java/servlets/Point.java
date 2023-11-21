package servlets;

public class Point {
    private int x;
    private double y;
    private int r;
    private boolean hit;
    private long time;

    public Point(int x, double y, int r, boolean hit, long time) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.hit = hit;
        this.time = time;
    }

    public int getX() {
        return this.x;
    }

    public double getY() {
        return this.y;
    }

    public int getR() {
        return this.r;
    }

    public boolean getHit() {
        return this.hit;
    }

    public long getTime() {
        return this.time;
    }

    public void setTime(Long time) {
        this.time = time;
    }
}
