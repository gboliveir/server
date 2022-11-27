-- CreateTable
CREATE TABLE "Documentation" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "statusId" INTEGER NOT NULL,
    "deliveryDate" TEXT NOT NULL,
    "obligation" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "attachment" BOOLEAN NOT NULL,
    CONSTRAINT "Documentation_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "Status" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
