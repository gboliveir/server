/*
  Warnings:

  - Added the required column `email` to the `Customer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `Customer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userType` to the `Customer` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Customer" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "statusId" INTEGER NOT NULL DEFAULT 0,
    "cnpj" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "cheatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "userType" TEXT NOT NULL,
    CONSTRAINT "Customer_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "Status" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Customer" ("cheatedAt", "cnpj", "id", "name", "statusId") SELECT "cheatedAt", "cnpj", "id", "name", "statusId" FROM "Customer";
DROP TABLE "Customer";
ALTER TABLE "new_Customer" RENAME TO "Customer";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
