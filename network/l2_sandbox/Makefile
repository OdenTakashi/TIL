.PHONY: up down ifinfo recv send send-c demo dump test switch host

MSG ?= hello
HOST ?= host-b

test:
	ruby test/ethernet_frame_test.rb

up:
	docker compose up -d --build

down:
	docker compose down

switch:
	docker compose exec host-b sh /app/scripts/as-switch.sh

host:
	docker compose exec host-b sh /app/scripts/as-host.sh

ifinfo:
	@echo "=== host-a ==="
	docker compose exec host-a ruby ifinfo.rb
	@echo "=== host-b ==="
	docker compose exec host-b ruby ifinfo.rb
	@echo "=== host-c ==="
	docker compose exec host-c ruby ifinfo.rb

recv:
	docker compose exec $(HOST) ruby recv.rb

send:
	docker compose exec host-a ruby send.rb "$(MSG)"

send-c:
	docker compose exec host-a ruby send.rb "$(MSG)" 02:00:00:00:00:0c

demo:
	./scripts/demo.sh

dump:
	docker compose exec $(HOST) tcpdump -i any -e -xx -nn -c 4 'ether proto 0x88b5'
