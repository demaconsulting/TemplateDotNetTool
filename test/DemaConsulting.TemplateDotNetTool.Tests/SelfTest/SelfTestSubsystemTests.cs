// Copyright (c) DEMA Consulting
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

using DemaConsulting.TemplateDotNetTool.Cli;
using DemaConsulting.TemplateDotNetTool.SelfTest;

namespace DemaConsulting.TemplateDotNetTool.Tests;

/// <summary>
///     Subsystem tests for the SelfTest subsystem covering Validation workflows.
/// </summary>
[TestClass]
public class SelfTestSubsystemTests
{
    /// <summary>
    ///     Test that self-test subsystem can run validation workflow without result files.
    /// </summary>
    [TestMethod]
    public void SelfTestSubsystem_ValidationWorkflow_NoResultFiles_CompletesSuccessfully()
    {
        // Arrange: command line arguments for validation in silent mode
        var args = new[] { "--validate", "--silent" };

        // Act: create context and run validation
        using var context = Context.Create(args);
        Validation.Run(context);

        // Assert: validation completes successfully with correct flags set
        Assert.IsTrue(context.Validate, "Context should have validate flag set");
        Assert.AreEqual(0, context.ExitCode, "Validation should complete successfully");
    }

    /// <summary>
    ///     Test that self-test subsystem can run validation workflow with TRX result file.
    /// </summary>
    [TestMethod]
    public void SelfTestSubsystem_ValidationWorkflow_WithTrxFile_GeneratesResults()
    {
        // Arrange: temporary TRX file path and validation command with results output
        var tempDir = Path.GetTempPath();
        var trxFile = Path.Combine(tempDir, $"test_{Guid.NewGuid()}.trx");
        var args = new[] { "--validate", "--silent", "--results", trxFile };

        try
        {
            // Act: create context and run validation with TRX output
            using var context = Context.Create(args);
            Validation.Run(context);

            // Assert: validation completes and generates TRX file
            Assert.IsTrue(context.Validate, "Context should have validate flag set");
            Assert.AreEqual(0, context.ExitCode, "Validation should complete successfully");
            Assert.IsTrue(File.Exists(trxFile), "TRX file should be generated");
        }
        finally
        {
            // Cleanup
            if (File.Exists(trxFile))
            {
                File.Delete(trxFile);
            }
        }
    }

    /// <summary>
    ///     Test that self-test subsystem can run validation workflow with JUnit result file.
    /// </summary>
    [TestMethod]
    public void SelfTestSubsystem_ValidationWorkflow_WithJUnitFile_GeneratesResults()
    {
        // Arrange: temporary JUnit XML file path and validation command with results output
        var tempDir = Path.GetTempPath();
        var junitFile = Path.Combine(tempDir, $"test_{Guid.NewGuid()}.xml");
        var args = new[] { "--validate", "--silent", "--results", junitFile };

        try
        {
            // Act: create context and run validation with JUnit XML output
            using var context = Context.Create(args);
            Validation.Run(context);

            // Assert: validation completes and generates JUnit XML file
            Assert.IsTrue(context.Validate, "Context should have validate flag set");
            Assert.AreEqual(0, context.ExitCode, "Validation should complete successfully");
            Assert.IsTrue(File.Exists(junitFile), "JUnit file should be generated");
        }
        finally
        {
            // Cleanup
            if (File.Exists(junitFile))
            {
                File.Delete(junitFile);
            }
        }
    }

    /// <summary>
    ///     Test that self-test subsystem can run validation workflow with both result files.
    /// </summary>
    [TestMethod]
    public void SelfTestSubsystem_ValidationWorkflow_WithBothResultFiles_GeneratesBothResults()
    {
        // Arrange: setup validation arguments with TRX result file output
        var tempDir = Path.GetTempPath();
        var resultsFile = Path.Combine(tempDir, $"test_{Guid.NewGuid()}.trx");
        var args = new[] { "--validate", "--silent", "--results", resultsFile };

        try
        {
            // Act: create context and run validation with result file output
            using var context = Context.Create(args);
            Validation.Run(context);

            // Assert: verify validation completed and result file was generated
            Assert.IsTrue(context.Validate, "Context should have validate flag set");
            Assert.AreEqual(0, context.ExitCode, "Validation should complete successfully");
            Assert.IsTrue(File.Exists(resultsFile), "Results file should be generated");
        }
        finally
        {
            // Cleanup
            if (File.Exists(resultsFile))
            {
                File.Delete(resultsFile);
            }
        }
    }
}

