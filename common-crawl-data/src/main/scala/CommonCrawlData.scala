import org.apache.spark.SparkContext
import org.apache.spark.SparkConf
import scala.util.{Failure, Success, Try}

object CommonCrawlData {
  def main(args: Array[String]) {
    val conf = new SparkConf().setAppName("Common Crawl Data")
    val sc = new SparkContext(conf)

    //TODO: Use Apache Commons CLI
    val data = sc.textFile(args(0))

    val uriLines = data.filter(_.startsWith("WARC-Target-URI: "))
    val hosts = uriLines.map(line => {
      Try { line.split("http://").apply(1).split("/").apply(0) } match {
        case Success(x) => x
        case Failure(exception) => "PARSE_ERROR_" + exception.getMessage
      }
    })
    val hostPageNum = hosts.countByValue
    val rank = sc.parallelize(hostPageNum.toSeq).sortBy(_._2 * -1)

    rank.foreach(x => {
      println(s"${x._1},${x._2}")
    })
  }
}