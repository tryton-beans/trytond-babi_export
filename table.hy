(import trytond.model [ModelSQL ModelView fields]
        trytond.pool [PoolMeta]
        openpyxl [Workbook])

(defclass Table [:metaclass PoolMeta]
  (setv __name__ "babi.table")

  (defn _compute [self [process None] [compute_warnings False]]
    (._compute (super) process compute_warnings)
    (.post-compute self))

  (defn post-compute [self]
    (.export-workbook self))

  (defn export-workbook [self]
    (setv records (.execute_query self)
          workbook (Workbook)
          ws workbook.active)
    (ws.append (list (map (fn [field] field.internal-name) self.fields_)))
    (for [record records]
      (setv row (ws.append (list record)))
      )
    ;;  filter first line
    (setv ws.auto_filter.ref ws.dimensions)
    (.save workbook "/tmp/table-test.xlsx")
    )

  )
