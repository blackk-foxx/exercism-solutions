public class Orm: IDisposable
{
    private Database database;

    public Orm(Database database)
    {
        this.database = database;
    }

    public void Begin()
    {
        CheckDbState(Database.State.Closed);
        this.database.BeginTransaction();
    }

    public void Write(string data)
    {
        try
        {
            CheckDbState(Database.State.TransactionStarted);
            this.database.Write(data);
        }
        catch 
        {
            this.database.Dispose();
        }
    }

    public void Commit()
    {
        try
        {
            CheckDbState(Database.State.DataWritten);
            this.database.EndTransaction();
        }
        catch
        {
            this.database.Dispose();
        }
    }

    public void Dispose() => this.database.Dispose();

    void CheckDbState(Database.State state)
    {
        if (this.database.DbState != state)
            throw new InvalidOperationException();
    }
}
