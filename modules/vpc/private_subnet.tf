# 一旦、コメントアウト
# 
# resource "aws_subnet" "private" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.0.64.0/24"
#   availability_zone       = "ap-northeast-1a"
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "private-subnet"
#   }
# }

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "private-route-table"
#   }
# }

# # EIPは静的なパブリックIPアドレスを付与するサービス
# resource "aws_eip" "nat_gateway" {
#   domain     = "vpc"
#   depends_on = [aws_internet_gateway.main]
# }

# # プライベートネットワークからインターネットへアクセスしたい場合はNATゲートウェイを使用する
# resource "aws_nat_gateway" "main" {
#   allocation_id = aws_eip.nat_gateway.id
#   subnet_id     = aws_subnet.public.id # パブリックサブネットに配置する点に注意
#   depends_on    = [aws_internet_gateway.main]
# }

# # プライベートネットワークからインターネットへアクセスするためのルーティング設定
# resource "aws_route" "private" {
#   route_table_id         = aws_route_table.private.id
#   gateway_id             = aws_nat_gateway.main.id
#   destination_cidr_block = "0.0.0.0/0"
# }

# # プライベートサブネットにルーティングテーブルを関連付ける
# resource "aws_route_table_association" "private" {
#   subnet_id      = aws_subnet.private.id
#   route_table_id = aws_route_table.private.id
# }
