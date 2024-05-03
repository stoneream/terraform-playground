resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-route-table"
  }
}

# インターネットとの通信を可能にするためのルーティング設定
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.main.id # インターネットゲートウェイを経由する
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_internet_gateway.main]
}

# パブリックサブネットにルーティングテーブルを関連付ける
# 特に指定しない場合は、デフォルトルートテーブルに関連付けされる
# が、デフォルトルートテーブルの利用はアンチパターンとされている
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
