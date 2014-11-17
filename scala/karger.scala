import scala.io.Source

object Karger {

  def time[R](block: => R): R = {
    val t0 = System.nanoTime()
    val result = block    // call-by-name
    val t1 = System.nanoTime()
    println("Elapsed time: " + (t1 - t0)/1000000.0 + "ms")
    result
  }

  def main(args: Array[String]) {

  }
}
