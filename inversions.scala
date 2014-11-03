import scala.io.Source
import scala.collection.mutable.ArrayBuffer

object Inversions {
  def bfInversions(arr: ArrayBuffer[Int]):Long = {
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

   def main(args: Array[String]) {
      var sample = ArrayBuffer(9,8,7,6,5,4,3,2,1)
      if (args.length > 0) {
        sample = ArrayBuffer[Int]()
        Source.fromFile(args(0)).getLines.foreach{ line =>
          sample += line.toInt
        }
      }
      print(bfInversions(sample))
   }
}
