part of '../../week4.dart';

class DetailMarketplacePage extends StatefulWidget {
  final Marketplace marketplace;

  const DetailMarketplacePage({Key key, this.marketplace}) : super(key: key);
  @override
  _DetailMarketplacePageState createState() => _DetailMarketplacePageState();
}

class _DetailMarketplacePageState extends State<DetailMarketplacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.marketplace.image,
                child: CachedNetworkImage(
                  imageUrl: widget.marketplace.image,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(
                      child: Icon(Icons.image,
                          color: Theme.of(context).cardColor)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: headerPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.marketplace.title}',
                    style: blackTextFont.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    intl.NumberFormat.currency(
                      locale: 'id_ID',
                      decimalDigits: 0,
                      symbol: 'Rp. ',
                    ).format(widget.marketplace.price),
                    style: blackTextFont.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),
                  StarWidget(star: widget.marketplace.star),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: headerPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi Produk',
                    style: blackTextFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${widget.marketplace.description}',
                    style: blackTextFont.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
