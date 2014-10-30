import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

object CommonCrawlData {
  def main(args: Array[String]) {
    val conf = new SparkConf().setAppName("Common Crawl Data")
    val sc = new SparkContext(conf)
    //TODO: Use Apache Commons CLI
    val data = sc.textFile(args(0))
    val uriLines = data.filter(_.startsWith("WARC-Target-URI: "))
    val hosts = uriLines.map(line => { scala.util.Try { line.split("http://").apply(1).split("/").apply(0) }.toOption.getOrElse("PARSE_ERROR") } )
    val hostPageNumber = hosts.countByValue
    val rank = hostPageNumber.toSeq.sortBy(_._2 * -1)
    rank.foreach(x => {println(s"${x._1},${x._2}")})
  }
}
