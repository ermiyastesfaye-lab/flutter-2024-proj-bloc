-- DropForeignKey
ALTER TABLE "orders" DROP CONSTRAINT "orders_cropId_fkey";

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_cropId_fkey" FOREIGN KEY ("cropId") REFERENCES "crops"("id") ON DELETE CASCADE ON UPDATE CASCADE;
