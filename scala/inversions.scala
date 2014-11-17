import scala.io.Source

object Inversions {
  def bfInversions(arr: Array[Int]):Long = {
    var count = 0L
    for(i <- arr.indices){
      for(j <- i+1 until arr.length){
        if(arr(j) < arr(i)){
          count += 1
        }
      }
    }
    count
  }

  def time[R](block: => R): R = {
    val t0 = System.nanoTime()
    val result = block    // call-by-name
    val t1 = System.nanoTime()
    println("Elapsed time: " + (t1 - t0)/1000000.0 + "ms")
    result
  }

  def main(args: Array[String]) {
    var sample = Array(9,8,7,6,5,4,3,2,1)
    if (args.length > 0) {
      time { sample = Source.fromFile(args(0)).getLines.map(_.toInt).toArray }
    }
    time { println("Brute-force inversions count: " + bfInversions(sample)) }
  }
}
