/*
  Warnings:

  - You are about to alter the column `statusId` on the `Customer` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - The primary key for the `Status` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Status` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Customer" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "statusId" INTEGER NOT NULL DEFAULT 0,
    "cnpj" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "cheatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Customer_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "Status" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Customer" ("cheatedAt", "cnpj", "id", "name", "statusId") SELECT "cheatedAt", "cnpj", "id", "name", "statusId" FROM "Customer";
DROP TABLE "Customer";
ALTER TABLE "new_Customer" RENAME TO "Customer";
CREATE TABLE "new_Status" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "customerId" TEXT NOT NULL,
    "name" TEXT NOT NULL
);
INSERT INTO "new_Status" ("customerId", "id", "name") SELECT "customerId", "id", "name" FROM "Status";
DROP TABLE "Status";
ALTER TABLE "new_Status" RENAME TO "Status";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
